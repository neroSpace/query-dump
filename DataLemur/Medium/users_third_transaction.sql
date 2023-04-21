WITH master_table AS(
SELECT
  user_id, 
  spend, 
  transaction_date, 
  RANK() OVER (
    PARTITION BY user_id
    ORDER BY transaction_date ASC
    ) AS transaction_number
FROM transactions
)
SELECT
  user_id,
  spend,
  transaction_date
FROM master_table
WHERE transaction_number = 3
-- SELECT
--   user_id, 
--   spend, 
--   transaction_date
-- FROM transactions
-- GROUP BY 1,2,3
-- HAVING RANK() OVER (
--     PARTITION BY user_id
--     ORDER BY transaction_date ASC
--     ) = 3