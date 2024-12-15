with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'DEPARTMENTS', ['DEPT_NO', 'DEPT_NAME']) }}
),

renamed as (
    select
        DEPT_NO as dept_no,
        DEPT_NAME as dept_name
    from source
)

select * from renamed
