{{
  config(
    materialized='table',
    post_hook=["
        GRANT USAGE ON SCHEMA {{target.schema}} TO GROUP bi_users;
        GRANT SELECT ON TABLE {{target.schema}}.bireport to group bi_users;
    "]
  )
}}

select * from {{ref('joins')}}