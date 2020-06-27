{{
  config(
    alias='dim_dates',
    materialized = "table"
  )
}}

SELECT  GENERATE_UUID() AS sk_dim_dates,
        date_day,
        date_actual,
        day_of_month,
        month_actual,
        year_actual,
        quarter_actual,
        day_of_week,
        day_of_quarter,
        day_of_year,
        week_of_year,
        day_name,
        month_name,
        fiscal_year,
        fiscal_quarter,
        is_holiday
FROM {{ ref('stg_dates') }}
ORDER BY date_actual DESC
