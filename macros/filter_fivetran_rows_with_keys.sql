{% macro filter_fivetran_rows_with_keys(source_name, table_name, key_columns=[]) %}
  (
    select *
    from {{ source(source_name, table_name) }}
    where _LINE is not null
      and _FIVETRAN_SYNCED is not null
      {% for column in key_columns %}
      and {{ column }} is not null
      {% endfor %}
  )
{% endmacro %}
