with cte as(
SELECT
  ROW_NUMBER() OVER(PARTITION BY company_id, title, description) AS list_duplicate,
  company_id,
  title,
  description
FROM job_listings
-- ORDER BY 3 asc
),
close_truth as(
select case when list_duplicate > 1 then 1 else 0 end as co_w_duplicate
from cte
)
select SUM(co_w_duplicate) as co_w_duplicate
from close_truth