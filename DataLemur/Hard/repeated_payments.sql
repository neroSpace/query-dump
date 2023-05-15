WITH master_table AS(
  SELECT
    *
    , LAG(transaction_timestamp) 
      OVER(PARTITION BY merchant_id, credit_card_id, amount 
        ORDER BY transaction_timestamp) as previous_transaction
  FROM transactions  
)
SELECT
  COUNT(CASE  
        WHEN (EXTRACT(EPOCH FROM transaction_timestamp)
              - EXTRACT(EPOCH FROM previous_transaction))/60 <= 10
        THEN 1 ELSE NULL END) AS payment_count
FROM master_table