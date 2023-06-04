WITH percentage_by_user AS
(
    SELECT
        user_id_sender
        , COUNT(case when action = 'accepted' THEN 1 ELSE NULL END)::float/COUNT(CASE WHEN action = 'sent' THEN 1 ELSE NULL END) AS perc
    FROM fb_friend_requests
    GROUP BY 1 
)
, user_by_date AS(
    SELECT
        DISTINCT
        user_id_sender
        , date
    FROM fb_friend_requests
    WHERE action = 'sent'
)
SELECT
    ubd.date
    , SUM(perc)/COUNT(*)
FROM percentage_by_user pbu
LEFT JOIN user_by_date ubd ON 
pbu.user_id_sender = ubd.user_id_sender
GROUP BY 1
ORDER BY 1 ASC