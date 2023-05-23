WITH salary_ranks AS(
    SELECT
        worker_id
        , salary
        , RANK() OVER(ORDER BY salary DESC) as salary_rank
    FROM worker
)
SELECT
    worker_title
FROM title
WHERE worker_ref_id IN(
    SELECT
        worker_id
    FROM salary_ranks
    WHERE salary_rank = 1
)