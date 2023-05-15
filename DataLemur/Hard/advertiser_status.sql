WITH payment_status AS(
  SELECT
    advertiser.user_id,
    advertiser.status,
    payment.paid
  FROM advertiser
  LEFT JOIN daily_pay AS payment
    ON advertiser.user_id = payment.user_id
  UNION
  SELECT
    payment.user_id,
    advertiser.status,
    payment.paid
  FROM daily_pay AS payment
  LEFT JOIN advertiser
    ON advertiser.user_id = payment.user_id
)

SELECT
  user_id
  , CASE 
      WHEN paid IS NULL THEN 'CHURN'
      WHEN paid IS NOT NULL AND (status != 'CHURN') THEN 'EXISTING'
      WHEN paid IS NOT NULL AND status = 'CHURN' THEN 'RESURRECT'
      WHEN status IS NULL THEN 'NEW'
    END AS new_status
FROM payment_status
-- LEFT JOIN daily_pay dp ON a.user_id = dp.user_id
-- WHERE a.user_id IS NOT NULL
ORDER BY 1 ASC

-- SELECT *
-- FROM advertiser