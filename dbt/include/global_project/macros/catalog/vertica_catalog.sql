
{% macro vertica__get_catalog() -%}

  {%- call statement('catalog', fetch_result=True) -%}

    with table_owners as (

        select
            schema_name as table_schema,
            table_name as table_name,
            schema_name as table_owner

        from v_catalog.all_tables

    ),

    tables as (

        select

            schema_name as table_schema,
            table_name,
            table_type

        from v_catalog.all_tables

    ),

    columns as (

        select
            table_schema,
            table_name,
            null as table_comment,
            column_name,
            ordinal_position as column_index,
            data_type as column_type,
            null as column_comment

        from v_catalog.columns

    )

    select *
    from tables
    join columns using (table_schema, table_name)
    join table_owners using (table_schema, table_name)

    where table_schema != 'v_catalog'
      and table_schema not like 'v_%'

    order by column_index

  {%- endcall -%}

  {{ return(load_result('catalog').table) }}

{%- endmacro %}
