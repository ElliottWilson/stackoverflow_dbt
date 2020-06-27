{{
  config(
    alias='question_fact__joined',
    materialized = "ephemeral"
  )
}}

WITH min_answers AS
(SELECT question_id,
        min(answer_creation_date)       AS first_answer_date
FROM {{ ref('stg_answers') }}
GROUP BY 1),

accepted_answers AS
(SELECT answer_id,
        answer_owner_user_id            AS accepted_answer_owner_user_id,
        answer_creation_date            AS accepted_answer_creation_date
FROM {{ ref('stg_answers') }}),

votes AS
(SELECT post_id,
        number_of_up_votes AS question_up_votes,
        number_of_down_votes AS question_down_votes
FROM {{ ref('votes_by_post__grouped') }}
)

SELECT
-- FK to other tables
       questions.question_id,
       question_owner_user_id,
       accepted_answer_id,
       accepted_answer_owner_user_id,
       question_last_editor_user_id,
       question_creation_date,
       question_last_activity_date,
       question_community_owned_date,
       first_answer_date,
       accepted_answer_creation_date,

-- Facts
       answer_count,
       question_comment_count,
       question_favorite_count,
       question_score,
       question_view_count,
       is_answered,
       question_tags_grouped,
       number_of_days_unanswered,
       number_of_days_since_last_activity,
       number_of_days_since_created,
       DATE_DIFF(first_answer_date, question_creation_date, DAY) AS number_of_days_to_first_answer,
       DATE_DIFF(accepted_answer_creation_date, question_creation_date, DAY) AS number_of_days_to_accepted_answer,
       question_up_votes,
       question_down_votes
FROM {{ ref('stg_questions') }} AS questions
LEFT JOIN min_answers AS first_answer ON questions.question_id = first_answer.question_id
LEFT JOIN accepted_answers ON accepted_answer_id = accepted_answers.answer_id
LEFT JOIN votes ON questions.question_id = votes.post_id
