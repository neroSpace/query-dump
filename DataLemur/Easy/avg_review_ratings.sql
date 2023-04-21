SELECT
  EXTRACT(MONTH from submit_date) AS mth,
  product_id AS product,
  ROUND(AVG(stars),2)
FROM reviews
GROUP BY 2, 1
ORDER BY 1, 2