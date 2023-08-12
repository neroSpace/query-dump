WITH union_table AS(
SELECT
    *
FROM fb_eu_energy
UNION
SELECT
    *
FROM fb_asia_energy
UNION
SELECT
    *
FROM fb_na_energy
)
, rank_total_energy AS(
SELECT
    date
    , SUM(cons  umption) AS total_energy
    , DENSE_RANK() OVER(ORDER BY SUM(consumption) DESC) ranks
FROM union_table
GROUP BY 1
)
SELECT
    date
    , total_energy
FROM rank_total_energy
WHERE ranks = 1