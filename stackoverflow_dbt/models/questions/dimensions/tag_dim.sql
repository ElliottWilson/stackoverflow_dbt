{{
  config(
    alias='tag_dim',
    materialized = 'table'
  )
}}

SELECT GENERATE_UUID() AS srgt_key,
       id AS question_id,
       category
FROM {{ source('stackoverflow_raw', 'posts_questions') }}
CROSS JOIN UNNEST(SPLIT(tags, '|')) AS category
