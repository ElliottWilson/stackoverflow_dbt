{{
  config(
    alias='votes_dim',
    materialized = 'table'
  )
}}

SELECT id,
       creation_date,
       post_id,
       vote_type_id
FROM `stackoverflow-280817.stackoverflow_raw.votes`