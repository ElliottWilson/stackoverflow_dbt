{{
  config(
    alias='dim_tags_split',
    materialized = "table"
  )
}}

SELECT srgt_key_tags_split,
       tags_split
FROM {{ ref('dim_tags_bridge') }}
CROSS JOIN UNNEST(SPLIT(question_tags_grouped,',')) AS tags_split
