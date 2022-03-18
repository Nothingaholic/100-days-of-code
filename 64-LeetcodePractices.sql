-- Find the Team Size
-- Amazon
-- https://leetcode.com/problems/find-the-team-size/
-- 41.24%
# Write your MySQL query statement below
-- for each team, count how many people
-- wrong approach, need to get information of the employee
-- and which team they are in, 
-- and the total number of people in that team
SELECT team_id, COUNT( team_id) as employees
FROM employee
GROUP BY team_id

with total_employees_per_team as (
                                SELECT team_id, COUNT( *) as team_size
                                FROM employee
                                GROUP BY team_id
                                ) 
SELECT e.employee_id, t.team_size 
FROM employee e, total_employees_per_team t
WHERE e.team_id = t.team_id


-- get the number of people for each team_id

SELECT e1.employee_id, COUNT( e1.employee_id) as team_size
FROM employee e1, employee e2
WHERE e1.team_id = e2.team_id
GROUP BY e1.employee_id
ORDER BY e1.employee_id
----------------------------------------------------------------------------------------
-- Ads Performance
-- https://leetcode.com/problems/ads-performance/
-- 91.62%
SELECT ad_id,
    IFNULL(ROUND(SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) 
    / SUM(CASE WHEN action != 'Ignored' THEN 1 ELSE 0 END)
    * 100, 2), 0) as ctr
FROM ads
GROUP BY ad_id
ORDER BY ctr DESC , ad_id 
----------------------------------------------------------------------------------------
-- List the Products Ordered in a Period
-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/
-- 90.70% 
SELECT product_name, SUM(unit) as unit
FROM  products p, orders o
WHERE p.product_id = o.product_id
AND order_date BETWEEN '2020-02-01' AND '2020-02-29'

GROUP BY p.product_id
HAVING SUM(unit) >= 100
----------------------------------------------------------------------------------------
-- Students With Invalid Departments
-- https://leetcode.com/problems/students-with-invalid-departments/
-- 98.66%
SELECT id, name
FROM students
WHERE department_id NOT IN (SELECT id
                            FROM departments)
----------------------------------------------------------------------------------------
-- NPV queries
-- https://leetcode.com/problems/npv-queries/



# SELECT n.id, n.year, IFNULL(n.npv,0) as npv
# FROM npv n
# LEFT JOIN queries q
# ON n.id = q.id
# AND n.year = q.year
# ORDER BY n.id

select q.id, q.year, ifnull(n.npv,0) as NPV
from queries q
left join npv n on q.id = n.id and q.year = n.year