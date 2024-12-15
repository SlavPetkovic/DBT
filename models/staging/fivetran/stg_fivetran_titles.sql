with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'TITLES', ['TITLE_ID', 'TITLE']) }}
),

renamed as (
    select
        TITLE_ID as title_id,
        TITLE as title
    from source
)

select * from renamed
