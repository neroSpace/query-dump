WITH summary AS (  
  SELECT  
    item_type,  
    SUM(square_footage) AS total_sqft,  
    COUNT(*) AS item_count  
  FROM inventory  
  GROUP BY item_type
),
prime_items AS (  
  SELECT  
    item_type,
    total_sqft,
    FLOOR(500000/total_sqft) AS prime_item_combination_count,
    (FLOOR(500000/total_sqft) * item_count) AS prime_item_count
  FROM summary  
  WHERE item_type = 'prime_eligible'
),
non_prime_items AS (
SELECT
  item_type,
  total_sqft,  
  FLOOR(
    (500000 - 
      (SELECT prime_item_combination_count * total_sqft FROM prime_items))  
      / total_sqft)  
      * item_count AS non_prime_item_count  
FROM summary
WHERE item_type = 'not_prime')

-- SELECT * from summary
-- SELECT * from prime_items
-- SELECT * from non_prime_items

SELECT 
  item_type, 
  prime_item_count AS item_count
FROM prime_items

UNION ALL

SELECT 
  item_type, 
  non_prime_item_count AS item_count
FROM non_prime_items;