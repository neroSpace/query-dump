/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH cust_pymnt_per_month AS(
  SELECT
	  customer_id
	  , EXTRACT(Year FROM payment_ts) AS year
	  , EXTRACT (MONTH FROM payment_ts) AS mon
	  , SUM(amount) as payment_by_month
  FROM payment
  GROUP BY 1,2,3
),
year_month_pymnt AS(
  SELECT
	  year
	  , mon
	  , COUNT(Case WHEN payment_by_month > 20 THEN 1 ELSE NULL END) AS num_hp_customers
  FROM cust_pymnt_per_month
  GROUP BY 1,2
  ORDER BY 3
  )

SELECT
	*
FROM year_month_pymnt
WHERE num_hp_customers >0
