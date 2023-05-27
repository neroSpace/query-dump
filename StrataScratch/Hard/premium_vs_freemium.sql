WITH cust_type_downloads AS(
    SELECT
        mud.user_id
        , mdf.date
        , mad.paying_customer
        , mdf.downloads
    FROM ms_user_dimension mud
    JOIN ms_acc_dimension mad ON mud.acc_id = mad.acc_id
    JOIN ms_download_facts mdf ON mud.user_id = mdf.user_id
)
, non_paying AS(
SELECT
    date
    , SUM(
        CASE 
            WHEN paying_customer = 'no'
            THEN downloads
        END )  AS non_paying
FROM cust_type_downloads
GROUP BY date, paying_customer
)
, paying as(
SELECT
    date
    , SUM(
        CASE 
            WHEN paying_customer = 'yes'
            THEN downloads
        END )  AS paying
FROM cust_type_downloads
GROUP BY date, paying_customer
)
SELECT
    np.date
    , np.non_paying
    , p.paying
FROM non_paying np
JOIN paying p ON np.date = p.date
WHERE np.non_paying > p.paying