SELECT
  ROUND(100.0 * SUM(CASE WHEN call_category IS NULL OR call_category LIKE '%n/a%' THEN 1 ELSE 0 END)/
  SUM(CASE WHEN call_category IS NOT NULL THEN 1 ELSE 1 END),1) AS calls_categorised
  -- SUM(CASE WHEN call_category IS NULL THEN 1 ELSE 0 END) AS uncategorised_calls,
  -- COUNT(*) AS categorised_calls,
  -- SUM(CASE WHEN call_category IS NOT NULL THEN 1 ELSE 1 END)
FROM callers;