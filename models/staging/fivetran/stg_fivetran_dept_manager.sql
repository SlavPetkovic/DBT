with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'DEPT_MANAGER', ['EMP_NO']) }}
),

renamed as (
    select
        DEPT_NO as dept_no,
        EMP_NO as emp_no
    from source
)

select * from renamed
