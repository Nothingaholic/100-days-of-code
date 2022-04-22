-- Median Employee Salary
-- https://leetcode.com/problems/median-employee-salary/

WITH salary_rank AS ( 
                SELECT id, company, salary, 
                    ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) AS rnk,
                    COUNT(id) OVER(PARTITION BY company) AS cnt
                FROM employee)
SELECT  id, company, salary
FROM salary_rank
WHERE rnk IN (FLOOR((cnt + 1) / 2), CEIL(((cnt + 1) / 2)))


----------------------------------------------------------------------------------------  

-- Find Cumulative Salary of an Employee
-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/

WITH info AS ( 
                SELECT *,
                        RANK() OVER(PARTITION BY id ORDER BY month DESC) as most_recent

                FROM employee
                GROUP BY id, month
                ORDER BY id, month)
                
SELECT id, month, 
        SUM(salary) OVER(PARTITION BY id ORDER BY month
                        RANGE BETWEEN 2 PRECEDING AND CURRENT ROW) as salary
FROM info
WHERE most_recent != 1
GROUP BY id, month
ORDER BY id, month DESC


# The window frame "RANGE ... CURRENT ROW ..." 
# includes all rows that have the same values in the ORDER BY expression as the current row. 
# For example, ROWS BETWEEN 2 PRECEDING AND CURRENT ROW means that the window of rows that the function operates on is three rows in size, 
# starting with 2 rows preceding until and including the current row.