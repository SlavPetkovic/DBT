with source as (
    select * from {{ source('fivetran', 'SALARIES') }}
),

renamed as (
    select
        EMP_NO as emp_no,
        SALARY as salary
    from source
)

select * from renamed
