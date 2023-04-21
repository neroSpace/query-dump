/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
WITH ranking_wand AS(
    SELECT
        w.id,
        wp.age,
        w.coins_needed,
        w.power,
        RANK() OVER(PARTITION BY wp.age, w.power ORDER BY w.power DESC, w.coins_needed ASC) as wand_ranking
    FROM wands w
    LEFT JOIN wands_property wp ON w.code = wp.code
    WHERE wp.is_evil = 0
    ORDER BY 4 DESC, 2 DESC
)
SELECT
    id,/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT
    DISTINCT
    h.hacker_id,
    h.name,
    s.challenge_id,
    MAX(s.score)OVER(PARTITION BY h.hacker_id, s.challenge_id) AS total_scores
FROM hackers h
LEFT JOIN submissions s ON h.hacker_id = s.hacker_id
-- GROUP BY h.hacker_id, h.name, s.challenge_id;
    age,
    coins_needed,
    power
FROM ranking_wand
WHERE wand_ranking = 1;