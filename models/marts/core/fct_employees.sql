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
        e.manager_emp_no,
        e.emp_title_id, -- Use EMP_TITLE_ID for the join
        s.salary,
        t.title
    from {{ ref('int_employees') }} e
    left join {{ ref('stg_fivetran_salaries') }} s
    on e.emp_no = s.emp_no
    left join {{ ref('stg_fivetran_titles') }} t
    on e.emp_title_id = t.title_id
),

department_metrics as (
    select
        dept_name,
        count(distinct emp_no) as total_employees,
        count(case when employment_status = 'Active' then 1 end) as active_employees,
        count(case when employment_status = 'Departed' then 1 end) as departed_employees,
        count(case when hire_year = year(current_date) then 1 end) as hires_this_year,
        count(case when exit_year = year(current_date) then 1 end) as departures_this_year,
        avg(tenure_years) as avg_tenure_years,
        avg(salary) as avg_salary,
        max(salary) as max_salary,
        min(salary) as min_salary
    from enriched_employees
    group by dept_name
),

time_metrics as (
    select
        hire_year,
        hire_month,
        exit_year,
        exit_month,
        count(case when employment_status = 'Active' then 1 end) as active_count,
        count(case when employment_status = 'Departed' then 1 end) as departed_count
    from enriched_employees
    group by hire_year, hire_month, exit_year, exit_month
)

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
    e.manager_emp_no,
    e.salary,
    e.title,
    dm.total_employees,
    dm.active_employees,
    dm.departed_employees,
    dm.hires_this_year,
    dm.departures_this_year,
    dm.avg_tenure_years,
    dm.avg_salary,
    dm.max_salary,
    dm.min_salary
from enriched_employees e
left join department_metrics dm
on e.dept_name = dm.dept_name
