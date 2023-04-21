SELECT candidate_id
FROM(
  SELECT
    candidate_id, COUNT(*) AS num_skill
  FROM candidates
  WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
  GROUP BY 1
-- HAVING num_skill = 3;
) AS table_1
WHERE num_skill = 3