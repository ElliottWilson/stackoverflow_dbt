{{
  config(
    alias='dim_question_details',
    materialized = "table"
  )
}}

SELECT GENERATE_UUID() AS sk_dim_question_details,
       question_id,
       question_title,
       question_body,
       question_tags_grouped,
       question_last_edit_display_name,
       question_last_editor_user_id,
       question_owner_display_name,
       question_owner_user_id,
FROM {{ ref('stg_questions') }}