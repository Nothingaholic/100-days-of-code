-- Customers Who Bought Products A and B but Not C
--https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/

-- 77.80%
WITH not_c AS (
                SELECT * 
                FROM orders
                WHERE customer_id NOT in(
                    SELECT customer_id
                    FROM Orders
                    WHERE product_name = 'C'))
SELECT * 
FROM customers
WHERE customer_id IN (SELECT DISTINCT c1.customer_id
                        FROM not_c c1, not_c c2
                            WHERE c1.customer_id = c2.customer_id
                        AND c1.product_name = 'A'
                        AND c2.product_name = 'B')

-- using LEAD ( slower 58.54%)
-- customer who bought b and c
SELECT customer_id,
                    product_name,
                LEAD(product_name,1,0) OVER (PARTITION BY customer_id ORDER BY product_name) AS 'bc'
                FROM orders o
             WHERE product_name != 'D'
             ORDER BY customer_id, product_name

-- bought a,b and not c
WITH bought_bc AS ( SELECT customer_id,
                    product_name,
                LEAD(product_name,1,0) OVER (PARTITION BY customer_id ORDER BY product_name) AS 'bc'
                FROM orders o
             WHERE product_name != 'D'
             ORDER BY customer_id, product_name)
             
SELECT * 
FROM bought_bc
WHERE product_name IN ('A', 'B') AND bc != 'C' 
GROUP BY customer_id
HAVING COUNT(*) >=2


-- join with customer table, to get the name            
WITH bought_bc AS ( SELECT customer_id,
                    product_name,
                LEAD(product_name,1,0) OVER (PARTITION BY customer_id ORDER BY product_name) AS 'bc'
                FROM orders o
             WHERE product_name != 'D'
             ORDER BY customer_id, product_name)
             
SELECT c.customer_id, customer_name
FROM customers c, bought_bc b
WHERE c.customer_id = b.customer_id
AND product_name IN ('A', 'B') AND bc != 'C' 
GROUP BY customer_id
HAVING COUNT(*) >=2
----------------------------------------------------------------------------------------
--  Page Recommendations
-- https://leetcode.com/problems/page-recommendations/

-- 87.92%
-- select all people who are friends with user one
SELECT 
                    CASE WHEN user1_id = '1' THEN user2_id
                    WHEN user2_id = '1' THEN user1_id
                    END AS friend_id
                    FROM friendship
                    WHERE user1_id = '1' or user2_id = '1'

-- print out the page_id for all users who are friends with one
-- exclude the page_id that user one liked                   

WITH friend_with AS( SELECT 
                    CASE WHEN user1_id = '1' THEN user2_id
                    WHEN user2_id = '1' THEN user1_id
                    END AS friend_id
                    FROM friendship
                    WHERE user1_id = '1' or user2_id = '1')
SELECT DISTINCT page_id as recommended_page
FROM likes l, friend_with f
WHERE l.user_id = f.friend_id
AND page_id NOT IN (SELECT page_id
                   FROM likes
                   WHERE user_id = '1') # not include page_id that user one liked


-- 99.33%
SELECT DISTINCT page_id AS recommended_page
FROM friendship AS f, likes AS l
WHERE (f.user1_id = l.user_id OR f.user2_id = l.user_id) AND # inner join on user_id
      (f.user1_id = 1 OR f.user2_id = 1) AND # if either user 1 or user 2 has id=1
      page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)  # not include page_id that user one liked
----------------------------------------------------------------------------------------
-- All People Report to the Given Manager
-- https://leetcode.com/problems/all-people-report-to-the-given-manager/

-- 84.86%
-- there are 3 hierarchies
-- employees (level 2) who directly report to the head of the company (level 1)
SELECT employee_id
    FROM employees
    WHERE manager_id = 1 AND employee_id != 1
    
UNION ALL

-- employees (level 3) who report to managers (level 2)
SELECT employee_id
   FROM employees
   WHERE manager_id IN (SELECT employee_id
                        FROM employees
                        WHERE manager_id = 1 AND employee_id != 1)
   
UNION ALL
-- employees (level 4) who report to managers (level 3)
SELECT employee_id FROM employees 
WHERE manager_id IN (
    SELECT employee_id
   FROM employees
   WHERE manager_id IN (SELECT employee_id
                        FROM employees
                        WHERE manager_id = 1 AND employee_id != 1))



-- 70.23%
SELECT e3.employee_id   
FROM employees e3, employees e2, employees e1
WHERE e3.manager_id = e2.employee_id
AND e2.manager_id = e1.employee_id
AND e1.manager_id = 1 and e3.employee_id != 1    


-- using CTE 
WITH direct_report AS (
                        SELECT employee_id
                        FROM employees
                        WHERE manager_id = 1 AND employee_id != 1),
    indirect_level2 AS(
                        SELECT employee_id
                        FROM employees
                        WHERE manager_id IN (SELECT employee_id  FROM direct_report)),
    indirect_level3 AS(
                        SELECT employee_id
                        FROM employees
                        WHERE manager_id IN (SELECT employee_id  FROM indirect_level2))
SELECT * FROM direct_report
UNION ALL 
SELECT * FROM indirect_level2
UNION ALL 
SELECT * FROM indirect_level3
    
----------------------------------------------------------------------------------------
-- Replace Employee ID With The Unique Identifier
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/


SELECT unique_id, name
FROM  employees e
LEFT JOIN employeeuni u
ON u.id = e.id
----------------------------------------------------------------------------------------
--  Students and Examinations
-- https://leetcode.com/problems/students-and-examinations/


-- 90.02%
-- query to count the number of exams each student took
WITH exam_count AS (
            SELECT DISTINCT student_id,  subject_name , COUNT(subject_name) as attended_exams
            FROM Examinations
            GROUP BY student_id, subject_name),
-- match student with each subject          
classes AS ( 
            SELECT student_id, student_name, subject_name
            FROM students s, subjects
            ORDER BY student_id)

-- left join the classes with exam_count,
-- return 0 if the student didn't take the exam
SELECT c.student_id, c.student_name, c.subject_name,
        CASE WHEN e.attended_exams IS NULL THEN 0 ELSE e.attended_exams END as attended_exams
            
FROM classes c
LEFT JOIN exam_count e
ON  c.student_id = e.student_id
AND c.subject_name = e.subject_name
ORDER BY c.student_id, c.subject_name

