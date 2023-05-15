/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH rented_rate AS(
	SELECT
  		f.film_id
  		, COUNT(CASE WHEN DATE(r.rental_ts) BETWEEN '2020-05-01' AND '2020-05-31' THEN 1 ELSE NULL END) AS rental_num
  	FROM film f
  	LEFT JOIN inventory i ON f.film_id = i.film_id
  	LEFT JOIN rental r ON i.inventory_id = r.inventory_id
	--WHERE DATE(r.rental_ts) BETWEEN '2020-05-01' AND '2020-05-31'
  	GROUP BY 1
),
demand_categories AS(
	SELECT
		film_id
		, CASE WHEN rental_num > 1 THEN 'in demand'
  			ELSE 'not in demand'
  			END AS demand_category
	FROM rented_rate
)
SELECT
	--*
	demand_category
	, COUNT(1)
FROM demand_categories
GROUP BY 1