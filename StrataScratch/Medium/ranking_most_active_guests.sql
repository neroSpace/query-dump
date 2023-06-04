WITH num_msg_per_guest AS(
    SELECT
        id_guest
        ,SUM(n_messages) AS sum_n_messages
    FROM airbnb_contacts
    GROUP BY id_guest
)
SELECT
    DENSE_RANK() OVER (ORDER BY sum_n_messages DESC) as ranking
    ,*
FROM num_msg_per_guest
