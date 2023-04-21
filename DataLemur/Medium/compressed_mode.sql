WITH master_table AS(
SELECT 
  item_count,
  order_occurrences,
  RANK() OVER(ORDER BY order_occurrences DESC) AS ranking
FROM items_per_order
)
SELECT
  item_count
FROM master_table
WHERE ranking = 1
ORDER BY 1 ASC;