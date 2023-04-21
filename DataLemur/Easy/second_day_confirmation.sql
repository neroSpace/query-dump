SELECT user_id FROM
(
SELECT 
  CASE WHEN
    signup_action = 'Confirmed' AND
    DATE_PART('day', t.action_date - e.signup_date) = 1
    then e.user_id END AS user_id
FROM emails e  
LEFT JOIN texts t ON e.email_id = t.email_id
) a
WHERE user_id is NOT NULL