{{
  config(
    alias='question_fact',
    materialized = "table"
  )
}}

SELECT GENERATE_UUID()                                         AS srgt_key,

-- FK to other tables
       question_fact.id                                        AS question_id,
       owner_user_id                                           AS question_owner_user_id,
       accepted_answer_id,
       NULL                                                    AS tag_id,
       accepted_answer.answer_owner_user_id                    AS accepted_answer_owner_user_id,
       last_editor_user_id                                     AS question_last_editor_user_id,

-- Facts
       answer_count,
       comment_count                                           AS question_comment_count,
       community_owned_date                                    AS question_community_owned_date,
       question_fact.creation_date                             AS question_creation_date,
       favorite_count                                          AS question_favorite_count,
       last_activity_date                                      AS question_last_activity_date,
       last_edit_date                                          AS question_last_edit_date,
       score                                                   AS question_score,
       view_count                                              AS question_view_count,
       CASE
           WHEN accepted_answer_id is NULL AND (answer_count = 0 OR answer_count IS NULL) THEN FALSE
           ELSE TRUE
       END                                                     AS is_answered,
--     Current date would normally be used instead of 2020-05-31 but the data set only has
--     date up to this date
       CASE
           WHEN accepted_answer_id is NULL THEN DATE_DIFF(DATE('2020-05-31'), DATE(question_fact.creation_date  ), DAY)
           ELSE NULL
       END                                                     AS number_of_days_unanswered,
       DATE_DIFF(DATE('2020-05-31'), DATE(question_fact.creation_date), DAY) AS number_of_days_since_last_activity,
       DATE_DIFF(DATE('2020-05-31'), DATE(question_fact.creation_date), DAY) AS number_of_days_since_created,
       DATE_DIFF(DATE(first_answer_date), DATE(question_fact.creation_date), DAY) AS number_of_days_to_answer
FROM {{ source('stackoverflow_raw', 'posts_questions') }} AS question_fact
    LEFT JOIN {{ref('users_dim')}} AS users ON question_fact.owner_user_id = users.user_id
    LEFT JOIN {{ref('first_answer_dim')}} AS first_answer ON question_fact.id  = first_answer.question_id
    LEFT JOIN {{ref('answer_dim')}} AS accepted_answer ON question_fact.accepted_answer_id = accepted_answer.answer_id