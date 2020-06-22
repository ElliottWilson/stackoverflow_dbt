{{
  config(
    alias='question_text_dim',
    materialized = "table"
  )
}}

SELECT GENERATE_UUID() AS srgt_key,
       id              AS question_id,
       title           AS question_title,
       body            AS question_body,
       tags            AS question_tags,
FROM {{ source('stackoverflow_raw', 'posts_questions') }}