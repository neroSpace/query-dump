/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH base_table AS(
  SELECT
	  c.customer_id
	  , COUNT(CASE WHEN DATE(r.rental_ts) BETWEEN '2020-05-01' AND '2020-05-31' THEN 1 ELSE NULL END) AS num_rental_may
   FROM customer c
   LEFT JOIN rental r ON c.customer_id = r.customer_id
   GROUP BY 1
  )
, hr_nhr AS(
  	SELECT
  		customer_id
  		, CASE WHEN num_rental_may > 0 THEN 'rented' ELSE 'never-rented' END AS has_rented
  	FROM base_table
  )
 
SELECT
	has_rented,
	COUNT(1)
FROM hr_nhr
GROUP BY 1

