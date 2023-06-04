SELECT 
    bike_number
    ,end_time
FROM(
    SELECT
        bike_number
        ,end_time
        , RANK() OVER(PARTITION BY bike_number ORDER BY end_time DESC) as last_used
    FROM dc_bikeshare_q1_2012
    ORDER BY 2 DESC
    ) Q
WHERE last_used = 1