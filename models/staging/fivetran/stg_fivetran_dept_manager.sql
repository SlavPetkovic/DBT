with source as (
    select * from {{ source('fivetran', 'DEPT_MANAGER') }}
),

renamed as (
    select
        DEPT_NO as dept_no,
        EMP_NO as emp_no
    from source
)

select * from renamed
