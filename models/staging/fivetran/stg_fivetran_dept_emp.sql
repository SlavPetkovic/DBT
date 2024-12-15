with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'DEPT_EMP', ['EMP_NO', 'DEPT_NO']) }}
),

renamed as (
    select
        EMP_NO as emp_no,
        DEPT_NO as dept_no
    from source
)

select * from renamed
