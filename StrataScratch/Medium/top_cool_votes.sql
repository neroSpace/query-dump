WITH cool_ranks AS(
select 
*
, RANK() OVER(ORDER BY cool DESC) as cool_rank
from yelp_reviews
)
SELECT
    business_name
    , review_text
FROM cool_ranks
WHERE cool_rank = 1