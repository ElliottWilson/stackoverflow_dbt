{{
  config(
    alias='votes_by_post__grouped',
    materialized = "ephemeral"
  )
}}

WITH up_votes AS
(SELECT
post_id,
count(id) AS number_of_up_votes
FROM {{ ref('base_votes') }}
WHERE vote_type_id = 2
GROUP BY 1),

down_votes AS
(SELECT
post_id,
count(id) AS number_of_down_votes
FROM {{ ref('base_votes') }}
WHERE vote_type_id = 3
GROUP BY 1)

SELECT vote_id,
       votes.post_id,
       number_of_up_votes,
       number_of_down_votes,
FROM {{ ref('base_votes') }} AS votes
LEFT JOIN up_votes ON votes.post_id = up_votes.post_id
LEFT JOIN down_votes ON votes.post_id = down_votes.post_id