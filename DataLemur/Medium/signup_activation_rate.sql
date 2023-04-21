WITH user_status AS (
SELECT
  user_id,
  signup_action
FROM emails e
LEFT JOIN texts t
  ON e.email_id = t.email_id
WHERE signup_action is not NULL
),
user_conter AS (
SELECT 
  SUM(CASE WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 END) AS confirmed_user,
  COUNT(user_id) as total_user
FROM user_status
)
SELECT
  -- confirmed_user,
  -- total_user,
  -- ROUND(confirmed_user/total_user, 4)
  ROUND(confirmed_user*1.00/total_user,2)
FROM user_conter
-- SELECT * FROM user_status