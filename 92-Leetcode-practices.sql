-- Monthly Transactions I
-- https://leetcode.com/problems/monthly-transactions-i/
SELECT SUBSTRING(trans_date, 1, 7) AS month, 
        country, COUNT(country) AS trans_count,
        SUM(amount) AS trans_total_amount,
        SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
        SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM transactions
GROUP BY month, country
----------------------------------------------------------------------------------------  
-- Monthly Transactions II
-- https://leetcode.com/problems/monthly-transactions-ii/


-- For each month and country, the count and amount of all approved transactions
WITH approval AS ( 
                SELECT SUBSTRING(trans_date, 1, 7) AS month,
                        country,
                        COUNT(*)AS approved_count,
                        SUM(amount) AS  approved_amount
                        FROM  transactions
                        WHERE state = 'approved'
                        GROUP BY month, country),

-- for each month and country, the count and amount of all charge backs
chargeback AS ( 
                SELECT SUBSTRING(c.trans_date, 1, 7) AS month,
                country, 
                COUNT(*) as chargeback_count,
                SUM(amount) AS chargeback_amount
                FROM chargebacks c, transactions t
                WHERE t.id = c.trans_id
                GROUP BY month, country),
-- all possible combination of month and country, where there exist either approved transactions or charge backs
info AS (
            SELECT month, country FROM approval
            UNION 
            SELECT month, country FROM chargeback)
    
   
SELECT i.month,
        i.country,
        IFNULL(approved_count,0) AS approved_count, 
        IFNULL(approved_amount,0) AS approved_amount,
        IFNULL(chargeback_count,0) AS chargeback_count,
        IFNULL(chargeback_amount,0) AS chargeback_amount
FROM info i
LEFT JOIN approval a
        ON i.month = a.month AND i.country = a.country
LEFT JOIN chargeback c
        ON i.month = c.month AND i.country = c.country


----------------------------------------------------------------------------------------  
-- Last Person to Fit in the Bus
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/
# Write your MySQL query statement below
WITH info AS ( SELECT person_name, 
                    SUM(weight) OVER(ORDER BY turn) as total_weight
                FROM queue)
SELECT person_name
FROM  info
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1

----------------------------------------------------------------------------------------  
-- The Most Recent Three Orders
-- https://leetcode.com/problems/the-most-recent-three-orders/

WITH info AS (
            SELECT name as customer_name, c.customer_id, order_id, order_date,
            count(c.customer_id),
            DENSE_RANK() OVER( PARTITION BY customer_id ORDER BY order_date DESC) AS rnk
            FROM customers c, orders o
            WHERE c.customer_id = o.customer_id
            GROUP BY c.customer_id, order_id)
            
SELECT customer_name, customer_id, order_id, order_date
FROM info
WHERE rnk <= 3
ORDER BY customer_name, customer_id, order_date DESC

----------------------------------------------------------------------------------------  
--  The Most Frequently Ordered Products for Each Customer
-- https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/
WITH info AS ( SELECT
                        customer_id, o.product_id,
                        DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(customer_id) DESC) as rnk,
                        product_name
                FROM orders o, products p
                WHERE o.product_id = p.product_id
                GROUP BY customer_id, product_id
                ORDER BY customer_id)
SELECT customer_id, product_id, product_name
FROM info
WHERE rnk = 1

