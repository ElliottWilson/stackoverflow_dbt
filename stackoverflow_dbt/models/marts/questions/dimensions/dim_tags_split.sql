{{
  config(
    alias='dim_tags_split',
    materialized = "table"
  )
}}

SELECT sk_tags_split,
       tags_split
FROM {{ ref('dim_tags_bridge') }}
CROSS JOIN UNNEST(SPLIT(question_tags_grouped,',')) AS tags_split
