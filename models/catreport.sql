/*
{{
    config(
        materialized='ephemeral'
        -- or --
        materialized='table'
        -- or --
        materialized='incremental',
        unique_key='category_id'
    )
}}
*/

{{
    config(
        materialized='table'
    )
}}

select * from {{source('sources','categories')}}
