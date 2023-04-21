WITH master_table AS(
SELECT
  c.customer_id,
  p.product_category
FROM customer_contracts c
LEFT JOIN products p ON c.product_id = p.product_id
),
master_table_2 AS(
SELECT
  customer_id,
  COUNT(DISTINCT product_category) AS cat_bought
FROM master_table
GROUP BY 1
)
SELECT
customer_id
from master_table_2
WHERE cat_bought = (
  SELECT COUNT(DISTINCT product_category)
  FROM products
)