{{
  config(
    alias='question_fact',
    materialized = "table"
  )
}}

SELECT md5(question_fact.question_id||coalesce(question_owner_user_id,0)||coalesce(accepted_answer_id,0)) AS id,

-- FK to other tables
       question_fact.question_id
       question_owner_user_id,
       accepted_answer_id,
       NULL AS tag_id,

-- Facts
       question_creation_date,
       question_last_activity_date,
       answer_count,
       question_comment_count,
       question_view_count,
       question_score,
       question_favorite_count,
       is_answered,
       number_of_days_unanswered,
       number_of_days_since_last_activity,
       first_answer_date,
       DATE_DIFF(DATE(first_answer_date), DATE(question_creation_date), DAY) AS number_of_days_to_answer
FROM  {{ref('post_questions_dim')}} AS question_fact
LEFT JOIN {{ref('users_dim')}} AS users ON question_fact.question_owner_user_id = users.id
LEFT JOIN {{ref('first_answer_dim')}} AS first_answer ON question_fact.question_id = first_answer.question_id


-- LEFT JOIN {{ref('answer_dim')}} AS accepted_answer ON question_fact.accepted_answer_id = accepted_answer.answer_id
-- LEFT JOIN {{ref('answer_dim')}} AS answer ON question_fact.question_id = answer.question_id
