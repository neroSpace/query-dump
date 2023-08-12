select 
    fp.post_date
    , COUNT(DISTINCT
        CASE WHEN
        fp.post_keywords LIKE '%spam%'
        THEN fp.post_id ELSE NULL END) * 100 /
    COUNT(DISTINCT fp.post_id) AS total_viewed_post
FROM facebook_post_views fpv
LEFT JOIN facebook_posts fp ON fpv.post_id = fp.post_id
GROUP BY 1