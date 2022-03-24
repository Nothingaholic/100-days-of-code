-- Reported Posts II
-- https://leetcode.com/problems/reported-posts-ii/

-- spam_removed table
-- count spam posts has been removed
WITH spam_removed AS(
                SELECT action_date, COUNT(DISTINCT a.post_id) as spam
                FROM actions a, removals r
                WHERE a.post_id = r.post_id
                AND extra = 'spam'
                GROUP BY a.action_date),

-- actions_detail
-- count total spam for each action_date
actions_detail AS (
                    SELECT action_date, COUNT(DISTINCT post_id) as total_spam
                    FROM actions
                    WHERE extra = 'spam'
                    GROUP BY action_date)
                    
SELECT ROUND(AVG(IFNULL(spam/total_spam,0))*100,2) AS average_daily_percent
FROM actions_detail a
LEFT JOIN spam_removed s
ON s.action_date = a.action_date

----------------------------------------------------------------------------------------
-- Article Views II
-- https://leetcode.com/problems/article-views-ii/
-- 91.59%
-- for each day, count the number of article that a person has viewed
# SELECT DISTINCT viewer_id as id, 
#     COUNT(DISTINCT article_id) as viewed_article,
#     view_date
# from views
# group by viewer_id, view_date
# having count(distinct article_id) > 1

SELECT DISTINCT viewer_id as id
from views
group by viewer_id, view_date
having count(distinct article_id) > 1 

----------------------------------------------------------------------------------------
-- Product Price at a Given Date
-- https://leetcode.com/problems/product-price-at-a-given-date/
----------------------------------------------------------------------------------------
-- -- add a column to rank the price changed,
-- the latest one rank #1
SELECT *,
RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS 'rank'
FROM products 
WHERE change_date <= '2019-08-16'

-- left join the product table with price_change table
-- with condition that the change_date before 2019-08-16
-- if the price = NULL, replace with 10
-- and rank = 1 ( the latest day )
WITH price_change AS(
                SELECT *,
                RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) as 'rank'
                FROM products
                WHERE change_date <= '2019-08-16')

SELECT DISTINCT p.product_id, IFNULL(c.new_price, 10) as price
FROM products p
LEFT JOIN price_change c
ON p.product_id = c.product_id
AND c.rank = 1
----------------------------------------------------------------------------------------
-- Find the Start and End Number of Continuous Ranges
-- https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/

-- add a row_index column to the log table
WITH range_table AS(
                    SELECT log_id, 
                    row_number() OVER(ORDER BY log_id) AS row_index
                    FROM logs)

SELECT MIN(log_id) AS start_id,
        MAX(log_id) AS end_id
FROM range_table
GROUP BY (log_id - row_index)
                    
-- want min(id) as start and max(id) as end
/*
log_id      row_index       log_id - row_index
1           1                       0
2           2                       0
3           3                       0
7           4                       3
8           5                       3
10          6                       4
*/



----------------------------------------------------------------------------------------
-- Apples & Oranges
-- https://leetcode.com/problems/apples-oranges/

-- using CTE
-- 78.35%
WITH apples AS (
                SELECT * FROM sales
                WHERE fruit='apples'),
oranges AS ( 
                SELECT * FROM sales
                WHERE fruit='oranges')
SELECT a.sale_date, a.sold_num - o.sold_num AS diff
FROM apples a, oranges o
WHERE a.sale_date = o.sale_date
GROUP BY a.sale_date

-- self join 
-- 45.83%
SELECT a.sale_date, a.sold_num - o.sold_num AS diff
FROM sales a, sales o
WHERE a.sale_date = o.sale_date
AND o.fruit = 'oranges' and  a.fruit = 'apples'
GROUP BY a.sale_date

-- using CASE 
-- 97.51%
SELECT sale_date,
        SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE -sold_num END) AS diff
FROM sales
GROUP BY sale_date