/*
1. For data safety, only SELECT statements are allowed
2. Results have been capped at 200 rows
*/
WITH first_letter AS(
	SELECT
  		CASE 
  			WHEN first_name LIKE 'A%' THEN 'a_actors'
 			 WHEN first_name LIKE 'B%' THEN 'b_actors'
  			 WHEN first_name LIKE 'C%' THEN 'c_actors'
  			ELSE  'other_actors'
  		END AS actor_category
  	FROM actor
)
SELECT
	actor_category
	, COUNT(1)
FROM first_letter
GROUP BY 1