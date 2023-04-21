SELECT 
  drug, 
  (SUM(total_sales)-SUM(cogs)) as total_profit 
FROM pharmacy_sales
group BY 1
ORDER BY 2 DESC LIMIT 3