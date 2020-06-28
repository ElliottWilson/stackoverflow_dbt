{{
  config(
    alias='dim_tags_bridge',
    materialized = "table"
  )
}}

SELECT sk_tags_split,
       question_id,
       question_tags_grouped
FROM {{ ref('tags_by_question__bridge') }}