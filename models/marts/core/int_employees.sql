with employees_with_departures as (
    select
        e.emp_no,
        e.first_name,
        e.last_name,
        e.sex,
        e.birth_date,
        cast(e.hire_date as date) as hire_date, -- Cast to DATE
        cast(d.exit_date as date) as exit_date, -- Cast to DATE
        e.emp_title_id, -- Include EMP_TITLE_ID
        -- Calculate employment status
        case 
            when d.exit_date is null then 'Active'
            else 'Departed'
        end as employment_status,
        -- Calculate tenure days and years
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
        -- Time-based columns
        year(cast(e.hire_date as date)) as hire_year,
        month(cast(e.hire_date as date)) as hire_month,
        year(cast(d.exit_date as date)) as exit_year,
        month(cast(d.exit_date as date)) as exit_month
    from {{ ref('stg_fivetran_employees') }} e
    left join {{ ref('stg_fivetran_departures') }} d
    on e.emp_no = d.emp_no
),

departments_with_employees as (
    select
        de.emp_no,
        de.dept_no,
        d.dept_name,
        dm.emp_no as manager_emp_no
    from {{ ref('stg_fivetran_dept_emp') }} de
    join {{ ref('stg_fivetran_departments') }} d
    on de.dept_no = d.dept_no
    left join {{ ref('stg_fivetran_dept_manager') }} dm
    on de.dept_no = dm.dept_no
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
        e.emp_title_id, -- Include EMP_TITLE_ID in the final output
        d.dept_name,
        d.manager_emp_no
    from employees_with_departures e
    left join departments_with_employees d
    on e.emp_no = d.emp_no
)

select * from final
