{{
  config(
    alias='post_questions_dim',
    materialized = "table"
  )
}}

SELECT id                       AS question_id,
       title                    AS question_title,
       body                     AS question_body,
       accepted_answer_id,
       answer_count,
       comment_count            AS question_comment_count,
       community_owned_date     AS question_community_owned_date,
       creation_date            AS question_creation_date,
       favorite_count           AS question_favorite_count,
       last_activity_date       AS question_last_activity_date,
       last_edit_date           AS question_last_edit_date,
       last_editor_display_name AS question_last_edit_display_name,
       last_editor_user_id      AS question_last_editor_user_id,
       owner_display_name       AS question_owner_display_name,
       owner_user_id            AS question_owner_user_id,
       score                    AS question_score,
       tags                     AS question_tags,
       view_count               AS question_view_count,
       CASE
           WHEN accepted_answer_id is NULL AND (answer_count = 0 OR answer_count IS NULL) THEN FALSE
           ELSE TRUE
       END                      AS is_answered,
--     Current date would normally be used instead of 2020-05-31 but the data set only has
--     date up to this date
       CASE
           WHEN accepted_answer_id is NULL THEN DATE_DIFF(DATE('2020-05-31'), DATE(creation_date), DAY)
           ELSE NULL
       END                                                      AS number_of_days_unanswered,
       DATE_DIFF(DATE('2020-05-31'), DATE(creation_date), DAY) AS number_of_days_since_last_activity,
       DATE_DIFF(DATE('2020-05-31'), DATE(creation_date), DAY) AS number_of_days_since_created
FROM `stackoverflow_raw.posts_questions`

