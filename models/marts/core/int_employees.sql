with employees_with_departures as (
    select
        e.emp_no,
        e.first_name,
        e.last_name,
        e.sex,
        e.birth_date,
        cast(e.hire_date as date) as hire_date,
        cast(d.exit_date as date) as exit_date,
        e.emp_title_id,
        case 
            when d.exit_date is null then 'Active'
            else 'Departed'
        end as employment_status,
        datediff('day', cast(e.hire_date as date), 
            case 
                when d.exit_date is null then current_date
                else cast(d.exit_date as date)
            end
        ) as tenure_days,
        round(datediff('day', cast(e.hire_date as date), 
            case 
                when d.exit_date is null then current_date
                else cast(d.exit_date as date)
            end
        ) / 365.0, 2) as tenure_years,
        year(cast(e.hire_date as date)) as hire_year,
        month(cast(e.hire_date as date)) as hire_month,
        year(cast(d.exit_date as date)) as exit_year,
        month(cast(d.exit_date as date)) as exit_month,
        row_number() over (partition by e.emp_no order by e.hire_date desc) as row_number -- Deduplication logic
    from {{ ref('stg_fivetran_employees') }} e
    left join {{ ref('stg_fivetran_departures') }} d
    on e.emp_no = d.emp_no
    where e.emp_no is not null
),

departments_with_employees as (
select
        de.emp_no,
        de.dept_no,
        d.dept_name,
        row_number() over (
            partition by de.emp_no 
            order by d.dept_name -- Adjust the ordering logic as needed
        ) as row_number
    from {{ ref('stg_fivetran_dept_emp') }} de
    join {{ ref('stg_fivetran_departments') }} d
    on de.dept_no = d.dept_no
    qualify row_number = 1 -- Keep only the first department for each employee
),

final as (
    select
        e.emp_no,
        e.first_name,
        e.last_name,
        e.sex,
        e.birth_date,
        e.hire_date,
        e.tenure_days,
        e.tenure_years,
        e.employment_status,
        e.hire_year,
        e.hire_month,
        e.exit_year,
        e.exit_month,
        e.emp_title_id,
        d.dept_name
    from employees_with_departures e
    left join departments_with_employees d
    on e.emp_no = d.emp_no
    where e.row_number = 1 -- Ensure only one row per emp_no
)

select * 
from final
