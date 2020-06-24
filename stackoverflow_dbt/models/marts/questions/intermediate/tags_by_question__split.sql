{{
  config(
    alias='tags_by_question__split',
    materialized = "ephemeral"
  )
}}

SELECT GENERATE_UUID() AS srgt_key_tags_split,
       question_id,
       question_tags_grouped
FROM {{ ref('stg_questions') }}
CROSS JOIN UNNEST(SPLIT(question_tags_grouped,',')) AS tags
