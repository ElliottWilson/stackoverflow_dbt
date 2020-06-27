{{
  config(
    alias='tags_by_question__split',
    materialized = "ephemeral"
  )
}}

SELECT srgt_key_tags_split,
       tags_split
FROM {{ ref('tags_by_question__bridge') }}
CROSS JOIN UNNEST(SPLIT(question_tags_grouped,',')) AS tags_split