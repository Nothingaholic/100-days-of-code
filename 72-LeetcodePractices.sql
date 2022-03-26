-- Count Student Number in Departments
-- https://leetcode.com/problems/count-student-number-in-departments/

-- 87.40%
WITH count_students AS ( SELECT dept_id, COUNT(dept_id) AS student_number
                       FROM student
                       GROUP BY dept_id)

SELECT dept_name, IFNULL(student_number,0) AS student_number
FROM department d
LEFT JOIN count_students c
ON d.dept_id = c.dept_id
ORDER BY student_number DESC, dept_name


-- 85.87%
SELECT dept_name, IFNULL(COUNT(s.dept_id),0) AS student_number
FROM department d
LEFT JOIN student s
ON d.dept_id = s.dept_id
GROUP BY d.dept_id
ORDER BY student_number DESC, dept_name
----------------------------------------------------------------------------------------
--  Customers Who Bought All Products
-- https://leetcode.com/problems/customers-who-bought-all-products/

-- 85.91%
SELECT customer_id
FROM product p, customer c
WHERE c.product_key = p.product_key
GROUP BY customer_id
HAVING COUNT(DISTINCT c.product_key) = ( SELECT COUNT(DISTINCT product_key) FROM product)

-- 97.04%
SELECT DISTINCT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM product)
----------------------------------------------------------------------------------------
-- Winning Candidate
-- https://leetcode.com/problems/winning-candidate/

-- write a query to count number of votes for each candidate
SELECT candidateid, COUNT(candidateid) as votes
                    FROM vote
                    GROUP BY candidateid
-- Select name of the candidate who has the largest number of votes 
-- 77.24%
WITH count_vote AS (SELECT candidateid, COUNT(candidateid) as votes
                    FROM vote
                    GROUP BY candidateid
                    ORDER BY votes DESC -- descending orders of vote
                    LIMIT 1) -- then only get the first one (max)

SELECT name
FROM candidate 
WHERE id IN (SELECT candidateid FROM count_vote)


-- 98.89% 
-- use subquery instead of CTE, faster
SELECT name
FROM candidate 
WHERE id = (SELECT candidateid 
             FROM vote
            GROUP BY candidateid
             ORDER BY COUNT(candidateid) DESC
             LIMIT 1)
----------------------------------------------------------------------------------------
-- Users That Actively Request Confirmation Messages
--  https://leetcode.com/problems/users-that-actively-request-confirmation-messages/

-- 97.35%
SELECT DISTINCT c1.user_id
FROM confirmations c1, confirmations c2
WHERE c1.user_id = c2.user_id
AND c2.time_stamp != c1.time_stamp
AND ABS(timestampdiff(second, c2.time_stamp, c1.time_stamp)) <= 3600 * 24
----------------------------------------------------------------------------------------
--    Product's Worth Over Invoices
-- https://leetcode.com/problems/products-worth-over-invoices/

-- Failse to return null value
-- need to print out all product
-- not only products that have invoices
SELECT name,
    SUM(i.rest) as rest,
    SUM(i.paid) as paid,
    SUM(i.canceled) as canceled,
    SUM(i.refunded) as refunded
FROM product p, invoice i
WHERE p.product_id = i.product_id
GROUP BY name
ORDER BY name

-- use left join instead
SELECT name,
        IFNULL(SUM(i.rest),0) as rest,
        IFNULL(SUM(i.paid),0) as paid,
        IFNULL(SUM(i.canceled),0) as canceled,
        IFNULL(SUM(i.refunded),0) as refunded
FROM product p
LEFT JOIN invoice i
ON p.product_id = i.product_id
GROUP BY name
ORDER BY name