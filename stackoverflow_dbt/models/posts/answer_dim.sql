{{
  config(
    alias='post_answer_dim',
    materialized = "table"
  )
}}

SELECT id                       AS answer_id,
       body                     AS answer_text,
       comment_count            AS answer_comment_count,
       community_owned_date     AS answer_community_owned_date,
       creation_date            AS answer_creation_date,
       last_activity_date       AS answer_last_activity_date,
       last_edit_date           AS answer_last_edit_date,
       last_editor_display_name AS answer_last_editor_display_name,
       last_editor_user_id      AS answer_last_editor_user_id,
       owner_display_name       AS answer_owner_display_name,
       owner_user_id            AS answer_owner_user_id,
       parent_id                AS question_id,
       post_type_id             AS answer_post_type_id,
       score                    AS answer_score
FROM `stackoverflow_raw.posts_answers`