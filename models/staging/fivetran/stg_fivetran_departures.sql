with source as (
{{ filter_fivetran_rows_with_keys('fivetran', 'DEPARTURES', ['EMP_NO','EXIT_DATE']) }}
),

renamed as (
    select
        EMP_NO as emp_no,
        EXIT_DATE as exit_date,
        EXIT_REASON as exit_reason
    from source
)

select * from renamed
