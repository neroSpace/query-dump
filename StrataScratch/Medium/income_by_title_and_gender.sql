WITH sum_salary AS(
    SELECT
        employee_title
        , sex
        , SUM(salary) as total_salary
        , COUNT(DISTINCT id) AS person_id
    FROM sf_employee
    WHERE id IN (
        SELECT
            DISTINCT
            worker_ref_id
        FROM sf_bonus
    )
    GROUP BY 1,2
)
, sum_bonus AS(
    SELECT
        sfe.employee_title
        , sfe.sex
        , SUM(sfb.bonus) as total_bonus
    FROM sf_bonus sfb
    LEFT JOIN sf_employee sfe
    ON sfb.worker_ref_id = sfe.id
    GROUP BY 1,2
)
SELECT
    ss.employee_title
    , ss.sex
    , (ss.total_salary + sb.total_bonus)/person_id as avg_compensation
FROM sum_salary ss
LEFT JOIN sum_bonus sb ON ss.employee_title = sb.employee_title AND ss.sex = sb.sex