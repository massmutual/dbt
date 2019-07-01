
{{
  config(
    materialized = "incremental",
    unique_key = "ID",
    sql_where = "source_date > (select max(source_date) from {{ this }})"
  )
}}

SELECT
    a as ID,
    sum(val) as tot_val,
    c as source_date,
    now() as update_time
FROM test.testtable1
GROUP BY ID, source_date


-- {% if is_incremental() %}
--   WHERE a in (SELECT ID FROM {{ this }}) AND
--   source_date > (select max(source_date) from {{ this }})
-- {% endif %}
