with rank_per_measurement AS(
SELECT
  DATE(measurement_time) as measurement_day,
  measurement_value,
  RANK() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time ASC) as ranking
FROM measurements
)
SELECT
  measurement_day,
  SUM(CASE WHEN MOD(ranking, 2) = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
  SUM(CASE WHEN MOD(ranking, 2) = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM rank_per_measurement
GROUP BY 1
;