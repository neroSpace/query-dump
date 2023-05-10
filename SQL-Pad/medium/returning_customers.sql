/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH cust_num_rental AS(
  SELECT
	  customer_id
	  , COUNT(CASE WHEN DATE(rental_ts) BETWEEN '2020-05-01' AND '2020-05-31' THEN 1 ELSE NULL END) AS num_rental_may
  	  , COUNT(CASE WHEN DATE(rental_ts) BETWEEN '2020-06-01' AND '2020-06-30' THEN 1 ELSE NULL END) AS num_rental_june
  FROM rental
  GROUP BY 1
  )
SELECT
	COUNT(CASE WHEN num_rental_may > 0 and num_rental_june > 0 THEN customer_id ELSE NULL END) AS num_cust
FROM cust_num_rental
--ORDER BY 2 DESC

