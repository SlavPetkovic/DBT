with source as (
    select * from {{ source('fivetran', 'DEPARTURES') }}
),

renamed as (
    select
        EMP_NO as emp_no,
        EXIT_DATE as exit_date,
        EXIT_REASON as exit_reason
    from source
)

select * from renamed
