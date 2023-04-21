WITH master_table AS(
SELECT
  p.caller_id,
  p.receiver_id,
  CASE WHEN p.caller_id = pi.caller_id THEN pi.country_id END AS caller_country,
  CASE WHEN p.receiver_id = pir.caller_id THEN pir.country_id END AS receiver_country
FROM phone_calls p
JOIN phone_info pi ON p.caller_id = pi.caller_id
JOIN phone_info pir ON p.receiver_id = pir.caller_id
)
SELECT
ROUND(
  100*SUM(CASE WHEN caller_country != receiver_country THEN 1 ELSE 0 END)::decimal/
  COUNT(*)
, 1)
FROM master_table