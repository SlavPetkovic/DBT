with enriched_employees as (
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
        e.dept_name,
        e.emp_title_id,
        s.salary,
        t.title
    from {{ ref('int_employees') }} e
    left join {{ ref('stg_fivetran_salaries') }} s
    on e.emp_no = s.emp_no
    left join {{ ref('stg_fivetran_titles') }} t
    on e.emp_title_id = t.title_id
)

select *
from enriched_employees
