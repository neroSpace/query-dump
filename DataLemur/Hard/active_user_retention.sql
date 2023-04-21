-- MY SOLUTION
-- WITH master_table AS(
-- SELECT
--   *,
--   EXTRACT(MONTH FROM event_date) AS month,
--   RANK() OVER(PARTITION BY user_id ORDER BY EXTRACT(MONTH FROM event_date) ASC)
-- FROM user_actions
-- WHERE EXTRACT(MONTH FROM event_date) = 6 OR EXTRACT(MONTH FROM event_date) = 7
-- )
-- SELECT
--   MAX(month) as month,
--   COUNT(DISTINCT user_id) as monthly_active_users
-- FROM master_table
-- WHERE rank >= 2

SELECT
  EXTRACT(MONTH FROM curr_month.event_date) AS month,
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users
FROM user_actions AS curr_month
WHERE EXISTS(
  SELECT last_month.user_id
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date)