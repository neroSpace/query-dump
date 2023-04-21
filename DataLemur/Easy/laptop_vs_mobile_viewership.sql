WITH master_table AS(
SELECT
  CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END AS laptop_views,
  CASE WHEN device_type IN ('phone', 'tablet') THEN 1 ELSE 0 END AS mobile_views
FROM viewership)
SELECT
  SUM(laptop_views) as laptop_views,
  SUM(mobile_views) as mobile_views
FROM master_table