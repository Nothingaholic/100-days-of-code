-- Sales Analysis III
-- https://leetcode.com/problems/sales-analysis-iii/
-- Amazon

-- wrong 
-- this query will give us all products that were sold in spring
-- we only want products ONLY sold in spring.
SELECT p.product_id, product_name
FROM product p, sales s
WHERE p.product_id = s.product_id
AND sale_date BETWEEN '2019-01-01' AND '2019-03-31'

-- write a subquery to get product not sold in Spring 
-- don't use <=, because we want to include product sold in that day as well
-- only want distinct product_id
 SELECT  DISTINCT(s.product_id), p.product_name
 FROM sales s, product p
 WHERE p.product_id = s.product_id
 AND s.product_id NOT IN ( SELECT  product_id
                      FROM sales
                      WHERE sale_date < '2019-01-01' 
                      OR sale_date > '2019-03-31')
 
----------------------------------------------------------------------------------------
-- Reported Posts
-- https://leetcode.com/problems/reported-posts/
-- Facebook

-- condition need: action_date = '2019-07-04', action = 'report'
-- we want report_reason(extra), and report_count (how many posts)

SELECT extra as report_reason, 
        count(DISTINCT(post_id)) as report_count
FROM actions
WHERE action_date = '2019-07-04'
AND action = 'report'
GROUP BY report_reason
----------------------------------------------------------------------------------------
-- User Activity for the Past 30 Days I
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/
-- Zoom, Facebook

SELECT activity_date as day, 
        COUNT(distinct user_id) as active_users
FROM activity 
WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27'
GROUP BY activity_date

----------------------------------------------------------------------------------------
-- Article Views I
-- https://leetcode.com/problems/article-views-i/
-- LinkedIn

SELECT viewer_id as id
FROM views
WHERE author_id = viewer_id
GROUP BY viewer_id
HAVING COUNT(viewer_id) >= 1
ORDER BY viewer_id 
----------------------------------------------------------------------------------------
-- Immediate Food Delivery I
-- https://leetcode.com/problems/immediate-food-delivery-i/
-- DoorDash

SELECT(
ROUND(
        -- count total number of immediate 
    (SELECT COUNT(*) 
        FROM delivery
        WHERE order_date = customer_pref_delivery_date)
        -- devide by the total number of orders
    / 
    (SELECT COUNT(*)
        FROM delivery)
* 100, 2)) as immediate_percentage