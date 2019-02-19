-- NH: for vertica temporary tables by default follow on commit delete semantics.
--     One needs to expressly specify on commit preserve rows.
-- NH: Also when using select the proper syntax is select into temporary table
{% macro vertica__create_table_as(temporary, relation, sql) -%}
  {% if temporary %}
    -- This is using vertica.sql in adapters in temporary mode;
    select * into temporary table  {{ relation.include(schema=(True)) }} on commit preserve rows
    from (
      {{ sql }}
    ) v;
  {% else %}
    -- This is from vertica.sql adapter and not using temporary: {{ relation }}
    create table
      {{ relation.include(schema=(True)) }}
    as (
      {{ sql }}
    );
  {% endif %}
{% endmacro %}
