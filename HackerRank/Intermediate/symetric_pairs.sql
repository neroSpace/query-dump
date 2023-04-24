/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH master_table AS(
    SELECT
        f.x,
        f.y,
        ROW_NUMBER() OVER(PARTITION BY f.x, f.y ORDER BY f.x ASC) as numb
    FROM Functions f
    JOIN Functions f1 ON f.x <= f1.x AND f1.y<=f.y
    WHERE f.x = f1.y AND f.y = f1.x AND f.x<=f.y
    )
SELECT
    DISTINCT
    x,
    y
FROM master_table
WHERE x != y or numb > 1;