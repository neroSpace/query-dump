
SELECT 
app_id,
ROUND(100.0*SUM(CASE WHEN event_type  = 'click' THEN 1 ELSE 0 END)/
SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END),2) AS ctr_rate
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = '2022'
GROUP BY 1
ORDER BY 1