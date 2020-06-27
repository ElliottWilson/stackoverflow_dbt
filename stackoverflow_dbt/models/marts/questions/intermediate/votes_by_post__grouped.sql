{{
  config(
    alias='votes_by_post__grouped',
    materialized = "ephemeral"
  )
}}

WITH up_votes AS
(SELECT
post_id,
count(vote_id) AS number_of_up_votes
FROM {{ ref('stg_votes') }}
WHERE vote_type_id = 2
GROUP BY 1),

down_votes AS
(SELECT
post_id,
count(vote_id) AS number_of_down_votes
FROM {{ ref('stg_votes') }}
WHERE vote_type_id = 3
GROUP BY 1)

SELECT votes.post_id,
       sum(number_of_up_votes) AS number_of_up_votes,
       sum(number_of_down_votes) AS number_of_down_votes,
FROM {{ ref('stg_votes') }} AS votes
INNER JOIN up_votes ON votes.post_id = up_votes.post_id
INNER JOIN down_votes ON votes.post_id = down_votes.post_id
GROUP BY 1