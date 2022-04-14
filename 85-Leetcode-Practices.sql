-- Second Degree Follower
-- https://leetcode.com/problems/second-degree-follower/


-- find people who follow at least 1 user
WITH first_condition AS (
                    SELECT follower
                    FROM follow 
                    GROUP BY follower
                    HAVING COUNT(follower) >= 1),
-- find people who are followed by at least 1 user
second_condition AS (
                        SELECT followee, COUNT(*) as num
                    FROM follow 
                    GROUP BY followee
                    HAVING COUNT(followee) >= 1)
SELECT follower, num
FROM first_condition f, second_condition s
WHERE f.follower = s.followee
ORDER BY follower


-- 0r
WITH info AS (
                SELECT DISTINCT follower as follower
                FROM follow)

SELECT i.follower, COUNT(f.followee) AS num
FROM info i, follow f
WHERE i.follower = f.followee
GROUP BY i.follower
ORDER BY i.follower

----------------------------------------------------------------------------------------
-- Highest Grade For Each Student
-- https://leetcode.com/problems/highest-grade-for-each-student/

WITH info AS ( SELECT *,
             DENSE_RANK() OVER(PARTITION BY student_id
                              ORDER BY grade DESC, course_id) as rnk
                FROM enrollments)
SELECT student_id,
        course_id,
        grade
FROM info 
WHERE rnk = 1
----------------------------------------------------------------------------------------
-- Active Businesses
-- https://leetcode.com/problems/active-businesses/

# Write your MySQL query statement below
WITH info AS ( 
                SELECT event_type, AVG(occurences) AS avg_activity
                FROM events
                GROUP BY event_type
    )
SELECT business_id
FROM events e, info i
WHERE e.event_type = i.event_type
AND occurences > avg_activity
GROUP BY business_id
HAVING COUNT(business_id) > 1

----------------------------------------------------------------------------------------
-- Number of Times a Driver Was a Passenger
-- https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/

WITH passenger_info AS (
                        SELECT  passenger_id,
                        COUNT(passenger_id) as cnt
                        FROM rides
                        GROUP BY passenger_id)
SELECT driver_id, IFNULL(cnt,0) AS cnt
FROM rides r
LEFT JOIN passenger_info p
ON r.driver_id = p.passenger_id
GROUP BY driver_id

----------------------------------------------------------------------------------------  
-- Capital Gain/Loss
-- https://leetcode.com/problems/capital-gainloss/   

SELECT stock_name,
    SUM(CASE WHEN operation = 'Buy' THEN -price 
    ELSE price END) AS capital_gain_loss
FROM stocks
GROUP BY stock_name