{{
  config(
    alias='fct_question',
    materialized = "table"
  )
}}

SELECT question_id AS id,

-- FK to question and answer detail dimensions
       question_id,
       accepted_answer_id,

-- The below join to the dim_user_table
       question_owner_user_id,
       accepted_answer_owner_user_id,
       question_last_editor_user_id,

-- The below join to the dim_dates table
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
       number_of_days_to_first_answer,
       number_of_days_to_accepted_answer,
       question_up_votes,
       question_down_votes
FROM {{ ref('question_fact__joined') }}