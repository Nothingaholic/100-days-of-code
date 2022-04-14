-- Find Total Time Spent by Each Employee
-- https://leetcode.com/problems/find-total-time-spent-by-each-employee/

SELECT event_day AS day,
        emp_id,
        SUM(out_time - in_time) AS total_time
FROM employees
GROUP BY event_day, emp_id
----------------------------------------------------------------------------------------
-- Convert Date Format
-- https://leetcode.com/problems/convert-date-format/
-- https://www.w3schools.com/sql/func_mysql_date_format.asp
SELECT Date_Format(day, "%W, %M %e, %Y") as day
FROM days
----------------------------------------------------------------------------------------
-- Investments in 2016
-- https://leetcode.com/problems/investments-in-2016/

-- first criteria 
SELECT tiv_2015 as c1
                        FROM insurance
                        GROUP BY tiv_2015
                        HAVING COUNT(tiv_2015) > 1

-- second criteria 
SELECT DISTINCT lat, lon
                FROM insurance
                 GROUP BY lat, lon
                 HAVING COUNT(*) = 1

-- final answer
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM insurance
-- 1st criteria
WHERE tiv_2015 IN (SELECT tiv_2015 as c1
                        FROM insurance
                        GROUP BY tiv_2015
                        HAVING COUNT(tiv_2015) > 1)
-- 2nd criteria 
AND (lat, lon) in (SELECT DISTINCT lat, lon
                FROM insurance
                 GROUP BY lat, lon
                 HAVING COUNT(*) = 1)
----------------------------------------------------------------------------------------
-- Tree Node
-- https://leetcode.com/problems/tree-node/

-- root
SELECT id, 'Root' as type
FROM tree 
WHERE p_id is NULL
UNION
-- inner

SELECT id, 'Inner' as type
FROM tree
WHERE id IN (SELECT DISTINCT p_id 
                      FROM tree 
                      WHERE p_id IS NOT NULL ) # subquery return either root or parents of other nodes
AND p_id IS NOT NULL
UNION 

SELECT id, 'Leaf' as type
FROM tree
WHERE id NOT IN (SELECT DISTINCT p_id 
                      FROM tree 
                      WHERE p_id IS NOT NULL )
AND p_id IS NOT NULL



-- another solution using windown funtion
SELECT id, 
    CASE WHEN p_id is NULL then 'Root'
    
         WHEN id IN (SELECT DISTINCT p_id 
                      FROM tree 
                      WHERE p_id is NOT NULL)
            AND p_id IS NOT NULL then 'Inner'
         ELSE 'Leaf' END as type
FROM tree

----------------------------------------------------------------------------------------
--  Shortest Distance in a Plane
-- https://leetcode.com/problems/shortest-distance-in-a-plane/

WITH distance AS (
            SELECT
            ROUND(SQRT((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2))),2)  as d
            FROM point2d p1, point2d p2
            WHERE p1.x != p2.x
            OR p1.y != p2.y )
SELECT MIN(d) as shortest
FROM distance

-- using lag
WITH distance AS ( SELECT x, y ,
                            LAG(x) OVER(ORDER BY x, y) as lagx1,
                            LAG(y) OVER(ORDER BY x, y) as lagy1,
                              LAG(x) OVER(ORDER BY y, x) as lagx2,
                              LAG(y) OVER(ORDER BY y, x) as lagy2
                 FROM point2d
            )
            
SELECT MIN(LEAST(ROUND(SQRT((POW(x - lagx1, 2) + POW(y - lagy1, 2))),2),
    ROUND(SQRT((POW(x - lagx2, 2) + POW(y - lagy2, 2))),2))) as shortest
FROM distance     