-- Consecutive Numbers
-- https://leetcode.com/problems/consecutive-numbers/


SELECT DISTINCT num AS ConsecutiveNums
FROM
(
SELECT num,LAG(num, 1) OVER(ORDER BY id) AS lag1, 
    LAG(num, 2) OVER (ORDER BY id) AS lag2
FROM logs
)t
WHERE num=lag1 and num=lag2;
----------------------------------------------------------------------------------------
-- Consecutive Numbers
-- https://leetcode.com/problems/consecutive-numbers/

-- This wont work with consecutive case,
-- it only count the num that appears 3 times
SELECT num as ConsecutiveNums
FROM logs
GROUP BY num
HAVING COUNT(num) > 3
LIMIT 1

SELECT DISTINCT num AS ConsecutiveNums
FROM
(
SELECT num,LAG(num, 1) OVER(ORDER BY id) AS lag1, 
    LAG(num, 2) OVER (ORDER BY id) AS lag2
FROM logs
)t
WHERE num=lag1 and num=lag2;
----------------------------------------------------------------------------------------
-- Friend Requests II: Who Has the Most Friends
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
-- 96.80%
-- UNION ALL requestAccepted with itself
-- to get all people with id
-- then count(id)
-- total id count for each person equals
-- number of friends the person has


WITH person AS (
    SELECT requester_id as id
    FROM requestAccepted
    UNION ALL 
    SELECT accepter_id 
    FROM requestAccepted)
SELECT id, COUNT(id) as num
FROM person
GROUP BY id
ORDER BY num DESC LIMIT 1

----------------------------------------------------------------------------------------
-- Unpopular books
-- https://leetcode.com/problems/unpopular-books/

-- subquery to get books that have sold more than 10 copies last year
SELECT book_id,
         sum(quantity) as quantity,
         dispatch_date
FROM orders
WHERE dispatch_date BETWEEN '2018-01-01' AND '2019-06-23'
GROUP BY book_id
HAVING sum(quantity) >= 10 


SELECT book_id, name
FROM books
WHERE available_from < '2019-05-23'
AND book_id NOT IN (SELECT book_id
                FROM orders
                # WHERE dispatch_date BETWEEN '2018-01-01' AND '2019-06-23'
                GROUP BY book_id
                HAVING IFNULL(SUM(
                    CASE WHEN dispatch_date > '2018-06-23' then quantity else 0 end),0) >= 10
                 )
----------------------------------------------------------------------------------------
-- New Users Daily Count
-- https://leetcode.com/problems/new-users-daily-count/

-- first time login for each user_id
SELECT user_id, min(activity_date)
                FROM traffic
                WHERE activity = 'login'
                    GROUP BY user_id

-- count number of user for each activity_date
-- only want activity_date >= '2019-04-01'
SELECT activity_date as login_date,
        COUNT(DISTINCT user_id) as user_count
FROM traffic
WHERE (user_id, activity_date) IN (SELECT user_id, min(activity_date)
                FROM traffic
                WHERE activity = 'login'
                    GROUP BY user_id)
AND activity_date >= '2019-04-01'
GROUP BY activity_date


