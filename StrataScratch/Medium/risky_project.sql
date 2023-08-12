WITH project_duration AS(
    SELECT
    id
    , start_date
    , end_date
    , (end_date::DATE - start_date::DATE) as proj_dur
    from linkedin_projects
),
emp_salary AS(
    SELECT
    lep.project_id
    , SUM(le.salary) as sum_salary
    FROM linkedin_emp_projects lep
    LEFT JOIN linkedin_employees le ON lep.emp_id = le.id
    GROUP BY 1
),
proj_info AS(
    SELECT
        lp.title
        , lp.budget
        , CEILING(es.sum_salary * pd.proj_dur / 365) AS prorate
    FROM linkedin_projects lp
    LEFT JOIN emp_salary es ON lp.id = es.project_id
    LEFT JOIN project_duration pd ON lp.id = pd.id
)
SELECT
    *
FROM proj_info
WHERE budget < prorate
ORDER BY 1 ASC
