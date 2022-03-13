-- Combine 2 table
-- https://leetcode.com/problems/combine-two-tables/
-- Write an SQL query to report the first name, last name, city,
-- and state of each person in the Person table. 
-- If the address of a personId is not present in the Address table, report null instead.

SELECT firstname, lastname, city, state
FROM person p
LEFT JOIN address a
ON p.personId= a.personId
----------------------------------------------------------------------------------------


-- Write an SQL query to find the employees who earn more than their managers.
-- Return the result table in any order.
-- https://leetcode.com/problems/employees-earning-more-than-their-managers/
SELECT e1.name as employee
FROM employee e1, employee e2
WHERE e1.managerId = e2.id
AND e1.salary > e2.salary
----------------------------------------------------------------------------------------

-- Duplicate Emails
-- Write an SQL query to report all the duplicate emails.
-- https://leetcode.com/problems/duplicate-emails/
SELECT email
FROM person p1
GROUP BY email
HAVING count(email) > 1

-- or 
SELECT p1.email
FROM  person p1, person p2
WHERE p1.email = p2.email 
AND p1.id > p2.id
----------------------------------------------------------------------------------------


-- Customers Who Never Order
-- https://leetcode.com/problems/duplicate-emails/

SELECT name as Customers
FROM customers c
WHERE c.id NOT IN (SELECT customerId
                  FROM orders)
----------------------------------------------------------------------------------------



-- Delete Duplicate Emails
-- https://leetcode.com/problems/delete-duplicate-emails/
DELETE p1
FROM  person p1, person p2
WHERE p1.email = p2.email 
AND p1.id > p2.id
