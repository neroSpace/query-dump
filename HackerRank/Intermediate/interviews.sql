SELECT
    con.contest_id,
    -- col.college_id,
    con.hacker_id,
    con.name,
    sum(ss.total_submissions) as total_submission,
    sum(ss.total_accepted_submissions) as total_accepted_submission,
    sum(vs.total_views) as total_view,
    sum(vs.total_unique_views)as total_unique_view
FROM contests con
LEFT JOIN colleges col ON con.contest_id = col.contest_id
LEFT JOIN challenges chl ON col.college_id = chl.college_id
LEFT JOIN (SELECT
            challenge_id,
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions
           FROM submission_stats
           GROUP BY challenge_id) ss ON chl.challenge_id = ss.challenge_id
LEFT JOIN (SELECT
            challenge_id,
            SUM(total_views) AS total_views,
            SUM(total_unique_views) AS total_unique_views
           FROM view_stats
           GROUP BY challenge_id) vs ON chl.challenge_id = vs.challenge_id
GROUP BY con.contest_id, con.hacker_id, con.name
HAVING
    sum(ss.total_submissions)> 0 OR
    sum(ss.total_accepted_submissions) > 0 OR
    sum(vs.total_views) > 0 OR
    sum(vs.total_unique_views) >0
ORDER BY 1 ASC;