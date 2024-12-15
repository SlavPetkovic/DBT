with source as (
    {{ filter_fivetran_rows_with_keys('fivetran', 'EMPLOYEES', ['EMP_NO', 'EMP_TITLE_ID', 'HIRE_DATE']) }}
),

deduplicated as (
    select
        EMP_NO,
        FIRST_NAME,
        LAST_NAME,
        SEX,
        BIRTH_DATE,
        HIRE_DATE,
        EMP_TITLE_ID, -- Include EMP_TITLE_ID
        row_number() over (partition by EMP_NO order by HIRE_DATE desc) as row_number
    from source
)

select *
from deduplicated
where row_number = 1 -- Keep only the latest row per EMP_NO
