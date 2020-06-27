{{
  config(
    alias='stg_dates',
    materialized = "ephemeral"
  )
}}

WITH date_spine AS (
    {{
    dbt_utils.date_spine(
    datepart="day",
    start_date="'2010-01-01'",
    end_date="datetime_add(CURRENT_DATETIME(), interval 3 month)")
    }}
    )

   , calculated as (
    SELECT date_day,
           EXTRACT(date FROM date_day)                                                                       AS date_actual,
           EXTRACT(day FROM date_day)                                                                        AS day_of_month,
           EXTRACT(month FROM date_day)                                                                      AS month_actual,
           EXTRACT(year FROM date_day)                                                                       AS year_actual,
           EXTRACT(quarter FROM date_day)                                                                    AS quarter_actual,
           EXTRACT(dayofweek FROM date_day)                                                                  AS day_of_week,
           EXTRACT(DAYOFYEAR FROM date_day)                                                                  AS day_of_year,
           EXTRACT(WEEK FROM date_day)                                                                       AS week_of_year,
           FORMAT_DATETIME("%A", date_day)                                                                   as day_name,
           FORMAT_DATETIME("%B", date_day)                                                                   as month_name,
           ROW_NUMBER()
           OVER (PARTITION BY EXTRACT(year FROM date_day), EXTRACT(quarter FROM date_day) ORDER BY date_day) AS day_of_quarter,
           CASE
               WHEN EXTRACT(month FROM date_day) < 2
                   THEN EXTRACT(year FROM date_day)
               ELSE (EXTRACT(year FROM date_day) + 1) END                                                    AS fiscal_year,
           CASE
               WHEN EXTRACT(month FROM date_day) < 2 THEN '4'
               WHEN EXTRACT(month FROM date_day) < 5 THEN '1'
               WHEN EXTRACT(month FROM date_day) < 8 THEN '2'
               WHEN EXTRACT(month FROM date_day) < 11 THEN'3'
               ELSE '4' END                                                                                  AS fiscal_quarter,
           CASE
                WHEN EXTRACT(month FROM date_day) = 1 AND EXTRACT(day FROM date_day) = 1 THEN true
                WHEN EXTRACT(month FROM date_day) = 12 AND EXTRACT(day FROM date_day) = 25 THEN true
                WHEN EXTRACT(month FROM date_day) = 12 AND EXTRACT(day FROM date_day) = 26 THEN true
                ELSE FALSE END                                                                               AS is_holiday,
    FROM date_spine
)

SELECT date_day,
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
FROM calculated
ORDER BY date_actual
