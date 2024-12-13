with source as (
    select * from {{ source('fivetran', 'EMPLOYEES') }}
),

renamed as (
    select
        _LINE as line_number,
        _FIVETRAN_SYNCED as fivetran_synced,
        EMP_NO as emp_no,
        EMP_TITLE_ID as emp_title_id,
        BIRTH_DATE as birth_date,
        FIRST_NAME as first_name,
        LAST_NAME as last_name,
        SEX as sex,
        HIRE_DATE as hire_date
    from source
)

select * from renamed

