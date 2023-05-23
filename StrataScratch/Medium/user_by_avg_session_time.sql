with user_session AS(
SELECT
    pl.user_id
    , EXTRACT(DAY FROM pl.timestamp) as date
    , min(pe.timestamp) - max(pl.timestamp) as session
FROM facebook_web_log pl
LEFT JOIN facebook_web_log pe ON pl.user_id = pe.user_id
WHERE pl.action = 'page_load'
    AND pe.action = 'page_exit'
    AND pe.timestamp > pl.timestamp
GROUP BY 1,2
)
SELECT
    user_id
    , AVG(session)
FROM user_session
GROUP BY 1
ORDER BY 1