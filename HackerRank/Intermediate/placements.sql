/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT
    s.name
FROM students s
LEFT JOIN friends f ON s.id = f.id
LEFT JOIN packages p ON s.id = p.id
LEFT JOIN packages p1 ON f.friend_id = p1.id
WHERE p.salary < p1.salary
ORDER BY p1.salary ASC;