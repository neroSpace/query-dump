with master_table as(
SELECT
  user_id,
  COUNT(*) as tweet_bucket
FROM tweets
WHERE EXTRACT(YEAR FROM tweet_date) = '2022'
GROUP BY 1
)
SELECT
  tweet_bucket,
  COUNT(user_id) AS users_num
FROM master_table
GROUP BY 1
;