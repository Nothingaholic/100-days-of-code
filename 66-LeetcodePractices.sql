--Average Time of Process per Machine
-- https://leetcode.com/problems/average-time-of-process-per-machine/

-- 94.71% 
SELECT  a1.machine_id,
        ROUND(AVG(ABS(a1.timestamp - a2.timestamp)),3) as processing_time
FROM activity a1, activity a2
WHERE a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
AND a1.activity_type = 'start' and a2.activity_type = 'end'
GROUP BY a1.machine_id


-- 98.26%
SELECT machine_id, 
ROUND(SUM(CASE WHEN activity_type = 'end' THEN timestamp
            ELSE -timestamp
            END )/ count(machine_id)*2,3) -- group by machine, so count(machine_id)=1
                                            -- need to * 2 as each machine runs 2 process
            as processing_time
FROM activity
GROUP BY machine_id

----------------------------------------------------------------------------------------
-- Recyclable and Low Fat Products
-- https://leetcode.com/problems/recyclable-and-low-fat-products/


SELECT product_id
FROM products
WHERE low_fats = 'Y'
AND recyclable = 'Y'

----------------------------------------------------------------------------------------
-- Product's Price for Each Store
-- https://leetcode.com/problems/products-price-for-each-store/


SELECT product_id,
        SUM(CASE WHEN store = 'store1' THEN price ELSE null END) as store1,
        SUM(CASE WHEN store = 'store2' THEN price ELSE null END) as store2,
        SUM(CASE WHEN store = 'store3' THEN price ELSE null END) as store3
FROM products
GROUP BY product_id
----------------------------------------------------------------------------------------
-- Find Customers With Positive Revenue this Year
-- https://leetcode.com/problems/find-customers-with-positive-revenue-this-year/
SELECT customer_id
FROM customers
WHERE year = '2021' AND revenue > 0

----------------------------------------------------------------------------------------
-- Ad-Free Sessions
-- https://leetcode.com/problems/ad-free-sessions/
SELECT session_id
FROM playback
WHERE session_id NOT IN (SELECT session_id
                            FROM playback p, ads a
                            WHERE p.customer_id = a.customer_id
                            AND timestamp BETWEEN start_time AND end_time)
