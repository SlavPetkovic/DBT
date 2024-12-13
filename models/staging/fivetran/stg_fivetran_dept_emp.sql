with source as (
    select * from {{ source('fivetran', 'DEPT_EMP') }}
),

renamed as (
    select
        EMP_NO as emp_no,
        DEPT_NO as dept_no
    from source
)

select * from renamed
