/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH score_hacker AS(
    SELECT
    DISTINCT
        h.hacker_id,
        h.name,
        s.challenge_id,
        MAX(s.score)
            OVER(PARTITION BY h.hacker_id, s.challenge_id)
            AS total_scores
    FROM hackers h
    LEFT JOIN submissions s ON h.hacker_id = s.hacker_id
)
SELECT
    hacker_id,
    name,
    SUM(total_scores) AS total_score
FROM score_hacker
WHERE total_scores > 0
GROUP BY hacker_id, name
ORDER BY 3 DESC, 1 ASC;
-- GROUP BY h.hacker_id, h.name, s.challenge_id;