{{
  config(
    alias='first_answer_dim',
    materialized = "ephemeral"
  )
}}

SELECT parent_id                AS question_id,
       min(creation_date)       AS first_answer_date
FROM `stackoverflow_raw.posts_answers`
GROUP BY 1