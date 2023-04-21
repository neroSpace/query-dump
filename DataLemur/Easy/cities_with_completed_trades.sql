with master_table as(
SELECT u.city, t.status
FROM trades t
LEFT JOIN users u ON t.user_id = u.user_id
WHERE t.status = 'Completed'
)
SELECT city, COUNT(*) AS total_orders
-- FROM trades t
FROM master_table
-- LEFT JOIN users u ON t.user_id = u.user_id
GROUP BY city
ORDER BY 2 DESC
LIMIT 3;