{{
  config(
    alias='tag_dim',
    materialized = 'table'
  )
}}

SELECT id AS tag_id
       Category
FROM `stackoverflow-280817.stackoverflow_raw.posts_questions`
CROSS JOIN UNNEST(SPLIT(tags, '|')) AS Category