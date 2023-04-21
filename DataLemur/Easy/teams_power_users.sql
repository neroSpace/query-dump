SELECT sender_id,
-- message_id
COUNT(DISTINCT message_id) AS message_count
-- FROM master_table
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8' AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY 1
-- HAVING EXTRACT(MONTH FROM sent_date) = '8' AND EXTRACT(YEAR FROM sent_date) = '2022'
ORDER BY 2 DESC
LIMIT 2;