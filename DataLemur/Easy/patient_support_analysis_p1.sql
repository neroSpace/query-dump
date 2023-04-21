WITH master_table AS(
SELECT policy_holder_id, COUNT(case_id) as number_of_calls
FROM callers
GROUP BY 1
)
SELECT COUNT(DISTINCT policy_holder_id) as member_count
FROM master_table
WHERE number_of_calls >=3