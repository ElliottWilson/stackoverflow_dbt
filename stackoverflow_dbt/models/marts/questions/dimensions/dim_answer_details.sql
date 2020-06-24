{{
  config(
    alias='dim_answer_details',
    materialized = "table"
  )
}}

SELECT srgt_key_answers,
       answer_id,
       answer_text,
       answer_community_owned_date,
       answer_creation_date,
       answer_last_activity_date,
       answer_last_edit_date,
       answer_last_editor_display_name,
       answer_last_editor_user_id,
       answer_owner_display_name,
       answer_owner_user_id,
       question_id,
       answer_post_type_id
FROM {{ ref('stg_answers') }}