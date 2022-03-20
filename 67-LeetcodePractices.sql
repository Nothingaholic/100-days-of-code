-- Rearrange Products Table
-- https://leetcode.com/problems/rearrange-products-table/
SELECT p1.product_id, 
        'store1' as store, 
        p1.store1 as price
        FROM products p1 WHERE store1 IS NOT NULL
UNION
SELECT p2.product_id, 
        'store2' as store, 
        p2.store2 as price
        FROM products p2 WHERE store2 IS NOT NULL
UNION
SELECT p3.product_id, 
        'store3' as store, 
        p3.store3 as price
        FROM products p3 WHERE store3 IS NOT NULL
----------------------------------------------------------------------------------------
-- Second Highest Salary
-- https://leetcode.com/problems/second-highest-salary/

-- first approach using limit
-- not work if there is no SecondHighestSalary 
-- ( case when table only have 1 salary)
SELECT salary as SecondHighestSalary
FROM employee 
ORDER BY salary DESC
LIMIT 1, 1

-- to fix that 
SELECT (SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 , 1)AS SecondHighestSalary;

-- subquery to get max(salary)
-- with condition
-- fastest 98.78%
SELECT MAX(Salary) AS SecondHighestSalary
 FROM Employee 
 WHERE Salary < (SELECT MAX(Salary) FROM Employee);
 
-- using NOT IN
SELECT MAX(Salary) AS SecondHighestSalary
 FROM Employee 
 WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);
 
-- self join 
-- select the max(e2.salary) from the second table,
-- where that value < salary from e1.

SELECT MAX(e2.salary) AS SecondHighestSalary
FROM employee e1, employee e2
WHERE e1.salary > e2.salary

-- using DESSE_RANK
-- RANK vs DENSE_RANK 
-- subquery to rank salary from highest to lowest
SELECT salary, DENSE_RANK() over(ORDER BY salary DESC) AS r
FROM Employee
-- now, we want the SecondHighestSalary ( where r=2)

SELECT MAX(salary) AS SecondHighestSalary
FROM (
SELECT salary, DENSE_RANK() over(ORDER BY salary DESC) AS r
FROM Employee) result
WHERE r=2

----------------------------------------------------------------------------------------
-- Nth Highest Salary
-- https://leetcode.com/problems/nth-highest-salary/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET  N = N - 1; #Set N to N-1 for the offset
  RETURN (
      SELECT distinct(Salary) FROM Employee
      ORDER BY Salary DESC
      LIMIT N,1 # Select records from Nth position and only take 1 record. 
      
  );
END

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT DISTINCT salary 
      FROM ( 
            SELECT salary ,
            DENSE_RANK () OVER (ORDER BY salary DESC) as r
          FROM employee
          ) result
      WHERE r=N
  );
END
----------------------------------------------------------------------------------------
-- Rank Scores
-- https://leetcode.com/problems/rank-scores/
SELECT score,
        DENSE_RANK() OVER(ORDER BY score DESC) as 'rank'
FROM scores
----------------------------------------------------------------------------------------
-- Department Highest Salary
-- https://leetcode.com/problems/department-highest-salary/

SELECT d.name as Department,
        e.name as Employee,
        salary
FROM employee e, department d
WHERE e.departmentID = d.id
AND (salary, d.id)  IN (SELECT MAX(salary), departmentId
                    FROM employee
                    GROUP BY departmentId)