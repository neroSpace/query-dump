with master_table AS(
SELECT
  issue_month,
  issue_year,
  card_name,
  issued_amount,
  RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month ASC) as month_issued
FROM monthly_cards_issued
)
SELECT
  card_name
  ,
  SUM(issued_amount) AS issued_amount
  -- , issued_amount
FROM master_table
WHERE month_issued = 1
GROUP BY 1
ORDER BY 2 DESC;