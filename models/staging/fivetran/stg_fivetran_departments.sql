with source as (
    select * from {{ source('fivetran', 'DEPARTMENTS') }}
),

renamed as (
    select
        DEPT_NO as dept_no,
        DEPT_NAME as dept_name
    from source
)

select * from renamed
