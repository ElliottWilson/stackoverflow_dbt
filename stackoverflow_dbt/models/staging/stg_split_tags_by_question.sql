{{
  config(
    alias='stg_split_tags_by_question',
    materialized = "ephemeral"
  )
}}

SELECT GENERATE_UUID() AS srgt_key_tags_split,
       question_id,
       category
FROM {{ ref('stg_questions') }}
CROSS JOIN UNNEST(SPLIT(tags,',')) AS category
