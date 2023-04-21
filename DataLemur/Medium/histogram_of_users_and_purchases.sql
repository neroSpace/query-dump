WITH master_table AS(
SELECT 
  user_id,
  product_id,
  transaction_date,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) as ranking
FROM user_transactions
order by 1, 4 ASC
)
SELECT
  transaction_date,
  user_id,
  COUNT(product_id) as purchase_count
FROM master_table
WHERE ranking = 1
GROUP BY 2,1
ORDER BY 1,2 ASC