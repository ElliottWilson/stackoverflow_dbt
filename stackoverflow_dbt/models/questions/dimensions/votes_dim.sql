{{
  config(
    alias='votes_dim',
    materialized = 'table'
  )
}}

WITH up_votes AS
(SELECT
post_id,
count(id) AS number_of_up_votes
FROM {{ source('stackoverflow_raw', 'votes') }}
WHERE vote_type_id = 2
GROUP BY 1),

down_votes AS
(SELECT
post_id,
count(id) AS number_of_down_votes
FROM {{ source('stackoverflow_raw', 'votes') }}
WHERE vote_type_id = 3
GROUP BY 1)

SELECT GENERATE_UUID() AS srgt_key,
       votes.post_id,
       number_of_up_votes,
       number_of_down_votes,
FROM {{ source('stackoverflow_raw', 'votes') }} AS votes
LEFT JOIN up_votes ON votes.post_id = up_votes.post_id
LEFT JOIN down_votes ON votes.post_id = down_votes.post_id