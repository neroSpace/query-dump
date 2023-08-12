WITH rank_fraud AS(
    select
    *
    , RANK() OVER(PARTITION BY state ORDER BY fraud_score DESC) as ranks
    from fraud_score
)
, percentile AS(
    SELECT
    *
    , CEILING(MAX(ranks * 0.05) OVER(PARTITION BY state)) as percentile_rank
    FROM rank_fraud
)
SELECT 
    policy_num
    , state
    , claim_cost
    , fraud_score
FROM percentile
WHERE ranks <= percentile_rank