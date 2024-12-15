with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'SALARIES', ['EMP_NO', 'SALARY']) }}
),

renamed as (
    select
        EMP_NO as emp_no,
        SALARY as salary
    from source
)

select * from renamed
