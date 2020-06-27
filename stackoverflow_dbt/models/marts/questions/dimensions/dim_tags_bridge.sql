{{
  config(
    alias='dim_tags_bridge',
    materialized = "table"
  )
}}

SELECT GENERATE_UUID() AS srgt_key_tags_split,
       question_id,
       question_tags_grouped
FROM {{ ref('stg_questions') }}