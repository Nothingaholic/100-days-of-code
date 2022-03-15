
-- Project Employees I
-- https://leetcode.com/problems/project-employees-i/
-- Meta

-- select employee_id with experience_years
SELECT employee_id,
experience_years
FROM employee

-- join the 2 tables, to get information of the project_id
-- WHERE employee_id has some experience_years from the table above
-- take the average, and round to 2

SELECT project_id,  
        ROUND(AVG(experience_years),2) as average_years
        FROM project p, employee e
        WHERE p.employee_id = e.employee_id
        AND (p.employee_id, experience_years) IN (SELECT employee_id,
                                                     experience_years
                                                    FROM employee)
        GROUP BY project_id


-- better solution 
-- dont need a subquery to find information about employee_id and experience_years
SELECT project_id, ROUND(AVG(experience_years),2) as average_years
FROM project p, employee e
        WHERE p.employee_id = e.employee_id
        GROUP BY project_id
----------------------------------------------------------------------------------------
-- Project Employees II
-- https://leetcode.com/problems/project-employees-ii/
-- Meta

-- count number of people in each project
-- return the max number of people 
SELECT count(project_id)
        FROM project
        GROUP BY project_id
        ORDER BY COUNT(project_id) DESC
        LIMIT 1

-- match that query with project table, to get the project_id
SELECT project_id
 FROM project
 GROUP BY project_id
 HAVING COUNT(project_id) = (SELECT count(project_id)
                    FROM project
                    GROUP BY project_id
                    ORDER BY COUNT(project_id) DESC
                    LIMIT 1) 

----------------------------------------------------------------------------------------
-- Project Employees III
-- https://leetcode.com/problems/project-employees-iii/

-- select project_id with max experience_year
SELECT project_id, MAX(experience_years)
FROM project p, employee e
WHERE p.employee_id = e.employee_id
GROUP BY project_id

-- want to find employee in the project, with highest years of experience
SELECT project_id, p.employee_id
FROM project p, employee e
WHERE p.employee_id = e.employee_id
AND (project_id, experience_years) IN ( SELECT project_id, MAX(experience_years)
                                        FROM project p, employee e
                                        WHERE p.employee_id = e.employee_id
                                        GROUP BY project_id)
----------------------------------------------------------------------------------------
-- Sales Analysis I
-- https://leetcode.com/problems/sales-analysis-i/
-- Amazon

-- select max total sale price
SELECT SUM(price)
FROM sales
GROUP BY seller_id
LIMIT 1

-- get seller_id with max total sale price
-- incorrect, did not get the higest total sale price,
-- just the first row 
SELECT seller_id
FROM sales
GROUP BY seller_id
HAVING SUM(price) = (SELECT SUM(price)
                    FROM sales
                    GROUP BY seller_id
                    LIMIT 1)
-- correct 
SELECT seller_id
FROM sales
GROUP BY seller_id
HAVING SUM(price) = (SELECT SUM(price)
                    FROM sales
                    GROUP BY seller_id
                     ORDER BY SUM(price)  DESC -- DESC order to get the highest
                    LIMIT 1)
                                
----------------------------------------------------------------------------------------
-- Sales Analysis II
-- https://leetcode.com/problems/sales-analysis-ii/
-- Amazon

-- subquery to get buyer_id to bought an iphone 
SELECT buyer_id
FROM product p, sales s
WHERE p.product_id = s.product_id
AND product_name = 'iphone'

-- we want buyer_id who did not buy an iphone 
-- and they bought an S8
-- need distinct to get unique value of buyer_id
SELECT DISTINCT buyer_id
FROM product p, sales s
WHERE p.product_id = s.product_id
AND buyer_id NOT IN (SELECT buyer_id
                         FROM product p, sales s
                         WHERE p.product_id = s.product_id
                         AND product_name = 'iphone')
AND product_name = 'S8'
