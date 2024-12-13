with source as (
    select * from {{ source('fivetran', 'TITLES') }}
),

renamed as (
    select
        TITLE_ID as title_id,
        TITLE as title
    from source
)

select * from renamed
