WITH highest_marketing AS(
    SELECT
        MAX(e.salary) as highest_mkt
    FROM db_employee e
    JOIN db_dept d ON e.department_id = d.id
    WHERE LOWER(d.department) = 'marketing'
)
, highest_engineering AS(
    SELECT
        MAX(e.salary) as highest_eng
    FROM db_employee e
    JOIN db_dept d ON e.department_id = d.id
    WHERE (d.department) = 'engineering'
)
SELECT
    ABS(highest_mkt-highest_eng) as salaries_difference
FROM highest_marketing, highest_engineering