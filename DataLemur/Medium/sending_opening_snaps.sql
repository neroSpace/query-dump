WITH master_table AS (
SELECT 
  ag.age_bucket,
  SUM(case when act.activity_type = 'send' then act.time_spent ElSE 0 END) AS send_timespent,
  SUM(case when act.activity_type = 'open' then act.time_spent ElSE 0 END) AS open_timespent,
  SUM(act.time_spent) AS total_timespent
FROM activities act LEFT JOIN age_breakdown ag ON act.user_id = ag.user_id
GROUP BY 1)
SELECT 
age_bucket,
ROUND(send_timespent/(send_timespent+open_timespent)*100.0, 2) as send_perc,
ROUND(open_timespent/(send_timespent+open_timespent)*100.0, 2) as send_perc
FROM master_table