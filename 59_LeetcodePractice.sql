
--  Sales Person
-- https://leetcode.com/problems/sales-person/

-- need to join 3 table
-- LEFT JOIN saleperson with orders because need 
-- all information from saleperson table but not the orders table

-- start with the company table first,
-- select comapny with name != 'RED'
SELECT name 
FROM company 
WHERE name NOT IN (SELECT name 
                        FROM company 
                        WHERE name = 'RED');

-- join that with the orders table, to get the information of sales_id
-- select only sales_id who did not have any orders related to the company with the name "RED"    
-- notice that #4 has 2 orders, one relates to the company with the name "RED", one doesn't
SELECT o.sales_id
    FROM company c, orders o
    WHERE o.com_id = c.com_id
      AND c.name NOT IN (SELECT name 
    FROM company 
    WHERE name = 'RED')   

-- now left join salesperson table with table above to get saleperson's name
--  with the condition sales_id not in the table above
SELECT s.name
FROM salesperson s
WHERE s.sales_id NOT IN (SELECT o.sales_id
        FROM company c, orders o
        WHERE o.com_id = c.com_id
                AND c.name IN (SELECT name -- don't want sales_id in this table either
        FROM company 
        WHERE name = 'RED'));
----------------------------------------------------------------------------------------
-- Triangle Judgement
-- https://leetcode.com/problems/triangle-judgement/

-- use CASE
-- CASE... (condition) THEN... (statement) ELSE.... END
SELECT x, y, z,
        CASE 
        WHEN x + y > z
            AND  x + z > y
            AND  y + z > x
        THEN 'Yes'
        ELSE 'No'
        END triangle
FROM triangle;

----------------------------------------------------------------------------------------
-- Shortest Distance in a Line
-- https://leetcode.com/problems/shortest-distance-in-a-line/

SELECT MIN(ABS(p1.x - p2.x)) as shortest
FROM point p1, point p2
WHERE p1.x != p2.x
----------------------------------------------------------------------------------------
-- salary swap
-- https://leetcode.com/problems/swap-salary/

UPDATE Salary 
SET sex = CASE 
    WHEN sex = "m" 
    THEN "f" 
    ELSE "m" 
    END
----------------------------------------------------------------------------------------
-- Biggest Single Number
-- https://leetcode.com/problems/biggest-single-number/

-- to select all single number 
SELECT num
from mynumbers
GROUP BY num
HAVING COUNT(*) = 1

-- select the max number from the table above
SELECT max(num) as num
FROM (SELECT num
from mynumbers
GROUP BY num
HAVING COUNT(*) = 1) t1