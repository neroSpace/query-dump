WITH purchase_durration AS(
SELECT
    user_id
    , created_at
    , EXTRACT(DAY FROM created_at) - EXTRACT(DAY FROM LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at)) as lag_date
FROM amazon_transactions
ORDER BY 1,2
)
SELECT
DISTINCT
    user_id
FROM purchase_durration
WHERE lag_date <= 7 AND lag_date IS NOT NULL