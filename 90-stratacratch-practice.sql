-- Count the number of user events performed by MacBookPro users
-- https://platform.stratascratch.com/coding/9653-count-the-number-of-user-events-performed-by-macbookpro-users?python=


SELECT event_name, COUNT(user_id) as event_count
FROM playbook_events
WHERE device LIKE '%macbook pro%'
GROUP BY event_name
ORDER BY event_count DESC
----------------------------------------------------------------------------------------  
-- Monthly Percentage Difference
-- https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?python=


WITH monthly_revenue AS ( 
SELECT 
        to_char(created_at, 'YYYY-MM') as year_month,
        SUM(value) as rev_monthly,
        LAG(SUM(value)) OVER() as prev_revenue
FROM    
        sf_transactions
GROUP BY year_month
ORDER BY year_month
)
SELECT year_month,
    ROUND(((rev_monthly- prev_revenue)/prev_revenue)* 100,2) as revenue_diff_pct
FROM monthly_revenue
----------------------------------------------------------------------------------------  
-- Premium vs Freemium
-- https://platform.stratascratch.com/coding/10300-premium-vs-freemium?python=


WITH info AS ( 
SELECT 
    date,
    SUM(CASE WHEN paying_customer = 'no' THEN downloads ELSE 0 END) as non_paying,
    SUM(CASE WHEN paying_customer = 'yes' THEN downloads ELSE 0 END) as paying
FROM ms_user_dimension u, ms_acc_dimension a, ms_download_facts d
WHERE u.acc_id = a.acc_id
AND u.user_id = d.user_id
GROUP BY date
ORDER BY date)
SELECT date, non_paying, paying 
FROM info
WHERE non_paying > paying
----------------------------------------------------------------------------------------  
-- Popularity Percentage
-- https://platform.stratascratch.com/coding/10284-popularity-percentage?python=

-- get a friend list for all user so it will be easier to join
WITH friends AS (
    SELECT user1 AS user_id, user2 AS friend FROM facebook_friends 
    UNION ALL 
    select user2 AS user_id, user1 AS friend FROM facebook_friends 
)

SELECT user_id, COUNT(*)::float
                    / 
                    (SELECT COUNT(DISTINCT user_id) FROM friends)
                  *100 as popularity_percent
-- ROUND((number_of_friends/COUNT(*))*100,2) AS popularity_percent
FROM friends
GROUP BY user_id
ORDER BY user_id


-- SELECT COUNT(DISTINCT user1) FROM facebook_friends


----------------------------------------------------------------------------------------  
-- Marketing Campaign Success [Advanced]
-- https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?python=

-- SELECT COUNT(DISTINCT user_id) FROM marketing_campaign
-- There are 58 users in total

-- user  information, 
-- do not include users who make multiple purchase on the same day
-- do not include users who only purchase the products they purchased on the first day
WITH user_info AS (
                        SELECT user_id, 
                        -- first time user buy something
                        MIN(created_at) OVER(PARTITION BY user_id) as first_time_purchased,
                        -- record each time user buy distinct product 
                        MIN(created_at) OVER(PARTITION BY user_id, product_id) as product_purchase_date
                        FROM marketing_campaign)
SELECT COUNT(DISTINCT user_id) 
FROM user_info
WHERE first_time_purchased != product_purchase_date