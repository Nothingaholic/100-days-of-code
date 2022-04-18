-- Game Play Analysis III
-- https://leetcode.com/problems/game-play-analysis-iii/

SELECT 
    player_id, 
    event_date,
    SUM(games_played) OVER(
    PARTITION BY player_id  ORDER BY event_date ) AS games_played_so_far
FROM activity

----------------------------------------------------------------------------------------  
-- Game Play Analysis IV
--https://leetcode.com/problems/game-play-analysis-iv/submissions/
-- find the first day that each user login
WITH user_info AS ( 
                SELECT player_id, min(event_date) as event_date
                FROM activity
                GROUP BY player_id),
-- count the number of time the user log back in the next day
game_info AS ( SELECT COUNT(u.player_id) as cnt 
                    FROM activity a, user_info as u
                    WHERE u.player_id = a.player_id
                AND DATEDIFF(a.event_date, u.event_date) = 1
             )
                
SELECT 
        ROUND(  
            IFNULL((SELECT cnt FROM game_info), 0)
            /
            (SELECT COUNT(DISTINCT player_id) FROM activity)
            ,2) as fraction
        

----------------------------------------------------------------------------------------  
-- Article Views II
-- https://leetcode.com/problems/article-views-ii/

SELECT DISTINCT viewer_id as id
FROM views
GROUP BY viewer_id, view_date
HAVING COUNT(DISTINCT article_id) > 1 
----------------------------------------------------------------------------------------  
-- Product Price at a Given Date
-- https://leetcode.com/problems/product-price-at-a-given-date/

# before '2019-08-16', get the latest change_date
WITH before_change AS (
                SELECT 
                        product_id,
                        MAX(change_date) as change_date,
                        new_price as price
                FROM products
                WHERE change_date <= '2019-08-16'
                GROUP BY product_id),
# after '2019-08-16', all price equals 10             
after_change AS ( 
            SELECT 
                    DISTINCT product_id, 
                    change_date,  
                    10  AS new_price
            FROM products
            WHERE change_date > '2019-08-16')
# SELECT * FROM before_change
# SELECT * FROM after_change


#  for products have both price before and after, choose the price before any change
SELECT p.product_id, p.new_price as price
FROM products p, before_change b
WHERE p.product_id = b.product_id
AND p.change_date = b.change_date

UNION 

SELECT product_id, new_price as price
FROM after_change 
WHERE product_id NOT IN ( SELECT product_id 
                            FROM before_change)

----------------------------------------------------------------------------------------  
-- Immediate Food Delivery II
-- https://leetcode.com/problems/immediate-food-delivery-ii/

WITH first_order AS (
                SELECT customer_id, order_date,
                        DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as rnk,
                        customer_pref_delivery_date
                FROM delivery),
delivery_info AS (
                SELECT customer_id, order_date,
                        CASE WHEN order_date = customer_pref_delivery_date
                                THEN 'immediate' ELSE 'scheduled' END as delivery
                FROM first_order 
                WHERE rnk = 1
            )
SELECT ROUND(SUM(delivery ='immediate')/COUNT(*)*100,2) as immediate_percentage
FROM delivery_info
