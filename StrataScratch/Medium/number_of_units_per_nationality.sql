SELECT
    ah.nationality
    , COUNT(DISTINCT unit_id)
FROM airbnb_hosts ah
LEFT JOIN airbnb_units au ON ah.host_id = au.host_id
WHERE ah.age < 30 AND unit_type = 'Apartment'
GROUP BY 1
ORDER BY 2 DESC