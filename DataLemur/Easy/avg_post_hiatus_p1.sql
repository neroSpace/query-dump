WITH master_table as(
SELECT user_id, MAX(post_date) as last_post_date, MIN(post_date) as first_post_date
-- DATEDIFF("DAY", MAX(post_date), MIN(post_date)) as days_between
FROM posts
WHERE user_id IN(
SELECT user_id
FROM posts
GROUP BY 1
HAVING COUNT(*) > 1 AND DATE(MAX(post_date)) < '01/01/2022'
)
GROUP BY 1
)
SELECT user_id, DATE_PART('day', last_post_date - first_post_date)
FROM master_table