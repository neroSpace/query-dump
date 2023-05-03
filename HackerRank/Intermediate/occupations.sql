/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH doctors as(
    SELECT Name,
    ROW_NUMBER()OVER(ORDER BY Name) as rn
    FROM Occupations
    WHERE occupation = 'Doctor'
),
professors as(
    SELECT Name,
    ROW_NUMBER()OVER(ORDER BY Name) as rn
    FROM Occupations
    WHERE occupation = 'Professor'
),
singers as(
    SELECT Name,
    ROW_NUMBER()OVER(ORDER BY Name) as rn
    FROM Occupations
    WHERE occupation = 'Singer'
),
actors as(
    SELECT Name,
    ROW_NUMBER()OVER(ORDER BY Name) as rn
    FROM Occupations
    WHERE occupation = 'Actor'
),
-- npo as(
--     SELECT
--         MAX(CASE WHEN occupation = 'Doctor' THEN Name END) AS doctors,
--         MAX (CASE WHEN occupation = 'Professor' THEN Name END) AS professors,
--         MAX (CASE WHEN occupation = 'Singer' THEN Name END) AS singers,
--         MAX (CASE WHEN occupation = 'Actor' THEN Name END) AS actors
--     FROM (
--             select name, occupation,
--             row_number() OVER(PARTITION BY occupation ORDER BY name) name_order
--             from Occupations
--         ) AS row_nm
--     GROUP BY name_order
-- ),
npo as(
    SELECT
        Name
        , occupation
        , ROW_NUMBER() OVER(PARTITION BY occupation ORDER BY Name) as name_order
    FROM Occupations
),
unoptmz_solution as(
    SELECT 
        d.name
        , p.name
        , s.name
        , a.name
    FROM professors p
    LEFT JOIN doctors d on d.rn = p.rn
    LEFT JOIN singers s on s.rn = p.rn
    LEFT JOIN actors a on a.rn = p.rn
)
-- SELECT
--     MAX(CASE WHEN occupation = 'Doctor' THEN Name END) AS doctors,
--     MAX(CASE WHEN occupation = 'Professor' THEN Name END) AS professors,
--     MAX(CASE WHEN occupation = 'Singer' THEN Name END) AS singers,
--     MAX(CASE WHEN occupation = 'Actor' THEN Name END) AS actors
-- FROM(
--     SELECT *
--     FROM npo
--     GROUP BY 3
-- );
SELECT * FROM actors