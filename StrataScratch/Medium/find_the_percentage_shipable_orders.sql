SELECT
    COUNT(
    DISTINCT
    CASE WHEN c.address IS NOT NULL
    THEN o.id ELSE NULL
    END) * 100
    / COUNT(DISTINCT o.id) AS percent_shipable
FROM orders o
LEFT JOIN customers c ON o.cust_id = c.id