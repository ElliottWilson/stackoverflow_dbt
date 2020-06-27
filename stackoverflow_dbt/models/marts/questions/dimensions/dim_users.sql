{{
  config(
    alias='dim_users',
    materialized = "table"
  )
}}

SELECT GENERATE_UUID() AS sk_dim_users,
       user_id,
       user_display_name,
       user_about_me,
       user_age,
       user_creation_date,
       user_last_access_date,
       user_location,
       user_reputation,
       user_up_votes,
       user_down_votes,
       user_views,
       user_profile_image_url,
       user_website_url
FROM {{ ref('stg_users') }}