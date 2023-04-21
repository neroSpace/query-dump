SELECT
  user_id,
  tweet_date,
  -- ROUND(SUM(tweet_count)::decimal/
  -- SUM(CASE WHEN user_id IS NOT NULL THEN 1 ELSE 0 END)
  -- ,2) AS rolling_avg_3d
  ROUND(avg(tweet_count)
  OVER(PARTITION BY user_id ORDER BY user_id, tweet_date
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM tweets
-- GROUP BY 1,2
-- ORDER BY 1,2 ASC;

-- SELECT * FROM tweets