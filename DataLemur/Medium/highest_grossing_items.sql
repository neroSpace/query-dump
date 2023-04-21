WITH master_table AS(
SELECT 
  category,
  product,
  SUM(spend) AS total_spend,
  RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
-- WHERE EXTRACT(YEAR FROM transaction_date) = '2022' AND RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) <= 2
WHERE EXTRACT(YEAR FROM transaction_date) = '2022' 
GROUP BY 1, 2
-- HAVING 
ORDER BY 1 ASC ,3 DESC,4 ASC
)
SELECT category, product, total_spend
FROM master_table
WHERE ranking <= 2;