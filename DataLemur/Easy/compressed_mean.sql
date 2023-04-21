SELECT
  ROUND(
  CAST(SUM(item_count * order_occurrences) as decimal)/
  CAST(SUM(order_occurrences) as decimal)
  -- * 1.00
  , 1) AS mean
  -- item_count,
  -- order_occurrences,
  -- item_count * order_occurrences as items
FROM items_per_order;