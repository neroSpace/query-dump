WITH salary_ranks AS(
    SELECT
        *
        , RANK() OVER(PARTITION BY id, first_name, last_name, department_id ORDER BY salary DESC) AS salary_rank
    FROM ms_employee_salary
)
SELECT
    id
    , first_name
    , last_name
    , department_id
    , salary
FROM salary_ranks
WHERE salary_rank = 1