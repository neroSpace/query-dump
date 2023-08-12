WITH apple_users AS(
    SELECT
    user_id
    , device
    FROM playbook_events
    WHERE LOWER(device) = 'macbook pro'
        OR LOWER(device) = 'iphone 5s'
        OR LOWER(device) = 'ipad air'
)
SELECT
    pu.language
    , COUNT(DISTINCT CASE WHEN
            LOWER(pe.device) = 'macbook pro'
            OR LOWER(pe.device) = 'iphone 5s'
            OR LOWER(pe.device) = 'ipad air'
            THEN pe.user_id ELSE NULL END) AS n_apple_users
    , COUNT(DISTINCT pe.user_id) AS n_total_users
FROM playbook_events pe
LEFT JOIN playbook_users pu ON pe.user_id = pu.user_id
GROUP BY 1
ORDER BY 3 DESC
