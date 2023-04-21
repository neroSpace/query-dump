WITH master_table AS (
  SELECT 
    manufacturer,
    SUM(CASE WHEN total_sales - cogs < 0 THEN 1 ELSE 0 END) AS drug_count,
    SUM(CASE WHEN total_sales - cogs < 0 THEN ABS(total_sales - cogs) ELSE NULL END)  AS total_loss
  FROM pharmacy_sales
  GROUP BY 1
  -- HAVING total_loss is NOT NULL
  ORDER BY 3 DESC
  )
SELECT *
FROM master_table
WHERE drug_count > 0