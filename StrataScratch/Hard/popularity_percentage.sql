WITH unite_users AS(
    SELECT user1 as users FROM facebook_friends
    UNION ALL
    SELECT user2 as users FROM facebook_friends
)
, popular AS(
    SELECT
        users,
        COUNT(*) as followers
    FROM unite_users
    GROUP BY 1
)
, total_user AS(
    SELECT
        COUNT(DISTINCT users) as total
    FROM unite_users
)
SELECT
    p.users,
    100.0*p.followers/tu.total
FROM popular p, total_user tu