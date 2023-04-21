SELECT 
manufacturer,
'$'|| ROUND(SUM(total_sales)/1000000,0) || ' ' || 'million'::text AS sale
FROM pharmacy_sales
GROUP BY 1
ORDER BY SUM(total_sales) DESC;