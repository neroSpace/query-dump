SELECT
  EXTRACT(YEAR FROM transaction_date) AS yr,
  product_id,
  SUM(spend) AS curr_year_spend,
  -- SUM(CASE WHEN EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM transaction_date) - 1
  --     THEN spend END) 
  LAG(SUM(spend), 1) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))
  AS prev_year_spend,
  ROUND(
  100*(
    SUM(spend) -
    LAG(SUM(spend), 1) 
    OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))
    )/
    LAG(SUM(spend), 1) 
    OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)),
  2) AS yoy_rate
FROM user_transactions
GROUP BY 1, 2
ORDER BY 2,1 ASC;