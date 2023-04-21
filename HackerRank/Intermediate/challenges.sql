/*
Enter your query here.
*/
WITH rank_hackers AS(
    SELECT
        h.hacker_id,
        h.name,
        COUNT(c.challenge_id) as num_challenge,
        RANK() OVER(partition by COUNT(c.challenge_id)
                    ORDER BY h.hacker_id ASC) AS ranking_hacker
    FROM hackers h
    LEFT JOIN challenges c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
    ORDER BY 3 DESC, 1
),
rank_distinct_hackers AS(
    SELECT
        num_challenge,
        COUNT(num_challenge) AS distinct_values
    FROM rank_hackers
    GROUP BY 1
)
SELECT
    rh.hacker_id,
    rh.name,
    rh.num_challenge
FROM rank_hackers rh
LEFT JOIN rank_distinct_hackers rdh ON rh.num_challenge = rdh.num_challenge
WHERE rdh.distinct_values = 1 
OR rh.num_challenge = (SELECT MAX(num_challenge)
                       FROM rank_hackers)
-- WHERE ranking_hacker = 1 OR 
-- num_challenge = (SELECT MAX(num_challenge)
--                  FROM rank_hackers)
-- ORDER BY 3 DESC, 1 ASC;