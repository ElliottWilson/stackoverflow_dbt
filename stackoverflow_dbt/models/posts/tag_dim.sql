{{
  config(
    alias='tag_dim',
    materialized = 'ephemeral'
  )
}}

SELECT id, Category
FROM `stackoverflow-280817.stackoverflow_raw.posts_questions`
CROSS JOIN UNNEST(SPLIT(tags, '|')) AS Category