/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH num_rental_per_day AS(
	SELECT
  			-- EXTRACT(DATE FROM rental_ts) AS day_in_may
 			  --rental_ts::timestamp::date as rental_day
  			d.date as rental_day
 			, COUNT(1) AS num_rentals
  	FROM rental r
    FULL OUTER JOIN dates d
    ON DATE(r.rental_ts) = d.date
    WHERE d.date BETWEEN '2020-05-01' AND '2020-05-31'
  	GROUP BY 1
),

--/*
good_bad AS(
SELECT
	*,
	CASE WHEN num_rentals > 100 THEN 'good_days' ELSE 'bad_days' END AS day_type
	--COUNT(CASE WHEN num_rentals > 100 THEN 1 ELSE 0 END) AS good_days
   --COUNT(CASE WHEN num_rentals > 100 THEN 0 ELSE 1 END) AS bad_days
FROM num_rental_per_day
)
SELECT
	COUNT(CASE WHEN day_type = 'good_days' THEN 1 ELSE NULL END) AS good_days
   , COUNT(CASE WHEN day_type ='bad_days' THEN 1 ELSE NULL  END) AS bad_days
FROM good_bad
--  */
/*
SELECT *
FROM num_rental_per_day
ORDER BY rental_day ASC
*/

/*
SELECT 
DATE(rental_ts) 
, COUNT(*)
FROM RENTAL
WHERE DATE(rental_ts) BETWEEN '2020-05-01' AND '2020-05-31'
GROUP by 1
*/

