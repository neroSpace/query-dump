/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH score_hacker AS(
    SELECT
        h.hacker_id,
        h.name,
        COUNT(submission_id) as full_scr_prob
    FROM submissions s
    LEFT JOIN hackers h ON s.hacker_id = h.hacker_id
    LEFT JOIN challenges c ON s.challenge_id = c.challenge_id
    LEFT JOIN difficulty d ON c.difficulty_level = d.difficulty_level
    WHERE s.score = d.score
    GROUP BY h.hacker_id, h.name
    ORDER BY 3 DESC, 1 ASC)
SELECT
    hacker_id,
    name
FROM score_hacker
WHERE full_scr_prob > 1;