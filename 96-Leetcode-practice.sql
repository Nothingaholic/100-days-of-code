-- Department Top Three Salaries
-- https://leetcode.com/problems/department-top-three-salaries/


WITH info AS (
                SELECT * ,
                    DENSE_RANK() OVER(PARTITION BY departmentId
                                     ORDER BY salary DESC) as rnk
                FROM employee)
    
SELECT d.name as Department,
    i.name as Employee,
    Salary
FROM info i, department d
WHERE i.departmentId = d.id
AND rnk <= 3

----------------------------------------------------------------------------------------  
-- Get the Second Most Recent Activity
-- https://leetcode.com/problems/get-the-second-most-recent-activity/

WITH info AS (
                SELECT *,
                    DENSE_RANK() OVER(PARTITION BY username
                                     ORDER BY endDate DESC) AS rnk,
                    COUNT(*) OVER(PARTITION BY username) as cnt
                FROM UserActivity)
SELECT DISTINCT username,
            activity, startDate, endDate
FROM info
WHERE rnk = 2 or cnt = 1 


----------------------------------------------------------------------------------------  
-- Trips and Users
-- https://leetcode.com/problems/trips-and-users/

WITH unbanned_users AS (
                    SELECT client_id, request_at AS day,
                    SUM(CASE WHEN status LIKE 'cancelled%' THEN 1
                            ELSE 0 END) as cnt
                    FROM trips
                    WHERE client_id NOT IN (SELECT users_id 
                                            FROM users
                                           WHERE banned = 'Yes')
                    AND driver_id NOT IN (SELECT users_id 
                                            FROM users
                                           WHERE banned = 'Yes')
                    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
                    GROUP BY id
                    ORDER BY request_at)
                                           
SELECT day, ROUND(AVG(cnt),2) AS 'Cancellation Rate' 
FROM unbanned_users
GROUP BY day