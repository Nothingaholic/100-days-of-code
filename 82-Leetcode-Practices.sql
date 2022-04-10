-- Bank Account Summary II
-- https://leetcode.com/problems/bank-account-summary-ii/
SELECT name, SUM(amount) AS balance
FROM transactions t, users u
WHERE t.account = u.account
GROUP BY t.account
HAVING SUM(amount) > 10000
----------------------------------------------------------------------------------------
-- Sellers With No Sales
--https://leetcode.com/problems/sellers-with-no-sales/

SELECT seller_name
FROM seller
WHERE seller_id NOT IN ( 
                        SELECT seller_id
                        FROM orders
                        WHERE sale_date >= '2020-01-01')
ORDER BY seller_name    
----------------------------------------------------------------------------------------
-- Percentage of Users Attended a Contest
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/

WITH user_info AS ( 
                    SELECT COUNT(user_id) AS count_user
                    FROM users
            )
SELECT contest_id, 
        ROUND(COUNT(DISTINCT user_id)/count_user *100,2) as percentage
FROM register r, user_info u
GROUP BY contest_id
ORDER BY percentage DESC, contest_id



SELECT contest_id, 
        ROUND(COUNT(DISTINCT user_id)/(SELECT COUNT(*) FROM users) *100,2) as percentage
FROM register 
GROUP BY contest_id
ORDER BY percentage DESC, contest_id
----------------------------------------------------------------------------------------
-- Fix Names in a Table
-- https://leetcode.com/problems/fix-names-in-a-table/
SELECT user_id,
        CONCAT(
            UPPER(SUBSTRING(name,1,1)), 
                LOWER(SUBSTRING(name, 2))) AS name
FROM users
 ORDER BY user_id     
----------------------------------------------------------------------------------------
-- Find Followers Count
-- https://leetcode.com/problems/find-followers-count/
SELECT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id