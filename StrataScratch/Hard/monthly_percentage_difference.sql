WITH monthly_revenue AS(
    SELECT
        DATE_TRUNC('month', created_at)::date as dates
        , SUM(value) as revenue
    FROM sf_transactions
    GROUP BY 1
    ORDER BY 1 ASC
)
SELECT
    to_char(dates, 'YYYY-MM') as year_month
    ,CASE 
        WHEN EXTRACT (MONTH FROM dates) > 1
        THEN ROUND((revenue - LAG(revenue) OVER(ORDER BY dates))/LAG(revenue) OVER(ORDER BY dates)*100,2)
        ELSE NULL
        END AS revenue_diff_pct
FROM monthly_revenue