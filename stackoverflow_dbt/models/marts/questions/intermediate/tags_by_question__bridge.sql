{{
  config(
    alias='tags_by_question__bridge',
    materialized = "ephemeral"
  )
}}

SELECT GENERATE_UUID() AS srgt_key_tags_split,
       question_id,
       question_tags_grouped
FROM {{ ref('stg_questions') }}