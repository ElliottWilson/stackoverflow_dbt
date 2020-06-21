{{
  config(
    alias='first_answer_dim',
    materialized = "ephemeral"
  )
}}

WITH min_answers AS
(SELECT parent_id                AS question_id,
        min(creation_date)       AS first_answer_date
FROM {{ source('stackoverflow_raw', 'posts_answers') }}
GROUP BY 1)

SELECT
GENERATE_UUID()          AS srgt_key,
question_id,
first_answer_date,
FROM min_answers