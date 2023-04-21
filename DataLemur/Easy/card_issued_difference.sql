WITH master_table AS(
  SELECT DISTINCT card_name, MAX(issued_amount) as maximum_issued, MIN(issued_amount) as minimum_issued
  FROM monthly_cards_issued
  GROUP BY 1
)
SELECT card_name, maximum_issued - minimum_issued AS difference
FROM master_table
WHERE card_name IN(
    SELECT card_name
    from master_table
    GROUP BY card_name, maximum_issued
    HAVING maximum_issued = MAX(maximum_issued) OR maximum_issued = MIN(maximum_issued)
)
ORDER BY difference DESC