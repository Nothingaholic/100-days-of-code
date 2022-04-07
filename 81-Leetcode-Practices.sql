-- Weather Type in Each Country
-- https://leetcode.com/problems/weather-type-in-each-country/

WITH weather_info AS(
    SELECT 
        country_id,
        AVG(weather_state) AS weather_state
    FROM 
        weather
    WHERE
        SUBSTRING(day,1,7) = '2019-11'
    GROUP BY
        country_id )
SELECT country_name, 
    CASE WHEN weather_state <= 15 THEN 'Cold'
        WHEN weather_state >= 25 THEN 'Hot'
        ELSE 'Warm' END AS weather_type
FROM weather_info w, countries c
WHERE w.country_id = c.country_id
----------------------------------------------------------------------------------------
-- Create a Session Bar Chart
-- https://leetcode.com/problems/create-a-session-bar-chart/

SELECT '[0-5>' AS bin ,
sum(CASE WHEN duration/60 BETWEEN 0 AND 5 THEN 1 ELSE 0 END ) AS total
FROM sessions
UNION
SELECT '[5-10>' AS bin ,
sum(CASE WHEN duration/60 BETWEEN 5 AND 10 THEN 1 ELSE 0 END ) AS total
FROM sessions
UNION
SELECT '[10-15>' AS bin ,
sum(CASE WHEN duration/60 BETWEEN 10 AND 15 THEN 1 ELSE 0 END ) AS total
FROM sessions
UNION
SELECT '15 or more' AS bin ,
sum(CASE WHEN duration/60 > 15 THEN 1 ELSE 0 END ) AS total
FROM sessions
----------------------------------------------------------------------------------------
-- Group Sold Products By The Date
-- https://leetcode.com/problems/group-sold-products-by-the-date/

SELECT 
    sell_date, 
    COUNT(DISTINCT product) as num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product) as products
FROM activities
GROUP BY sell_date
----------------------------------------------------------------------------------------
-- Fix Product Name Format
-- https://leetcode.com/problems/fix-product-name-format/

SELECT 
        LOWER(TRIM(product_name)) AS product_name, #The TRIM() function removes the space character OR other specified characters from the start or end of a string.
        SUBSTRING(sale_date, 1, 7) AS sale_date,
        COUNT(product_name) AS total
FROM sales
GROUP BY 1, 2
ORDER BY 1, 2
----------------------------------------------------------------------------------------
-- Customer Who Visited but Did Not Make Any Transactions
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/

SELECT 
        customer_id, 
        COUNT(customer_id) AS count_no_trans
FROM visits
WHERE visit_id NOT IN (SELECT visit_id FROM transactions)
GROUP BY customer_id