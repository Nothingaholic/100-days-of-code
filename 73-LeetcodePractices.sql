-- The Number of Rich Customers
-- https://leetcode.com/problems/the-number-of-rich-customers/

--96.31%
SELECT COUNT(DISTINCT customer_id) as rich_count
FROM store
WHERE amount > 500
----------------------------------------------------------------------------------------
--  Group Employees of the Same Salary
--  https://leetcode.com/problems/group-employees-of-the-same-salary/

-- 88.31%
WITH team AS (
                SELECT salary
                FROM employees
                GROUP BY salary
                HAVING COUNT(salary) >= 2)
SELECT e1.employee_id,
        e1.name,
        e1.salary,
        DENSE_RANK() OVER( ORDER BY e1.salary) AS team_id
FROM employees e1, employees e2
WHERE e1.salary = e2.salary 
AND e1.salary IN ( SELECT * FROM team)
GROUP BY e1.employee_id
ORDER BY team_id, e1.employee_id
----------------------------------------------------------------------------------------
-- Maximum Transaction Each Day
-- https://leetcode.com/problems/maximum-transaction-each-day/

-- 98.45%
WITH rank_amount AS(
                    SELECT *,
                    DENSE_RANK() OVER(PARTITION BY date(day) ORDER BY amount DESC) as rnk
                    FROM transactions
                    GROUP BY day
                    )
SELECT transaction_id FROM rank_amount
WHERE rnk = 1
ORDER BY transaction_id
----------------------------------------------------------------------------------------
-- Count Salary Categories
-- https://leetcode.com/problems/count-salary-categories/

-- 97.75%
SELECT 'Low Salary' AS category,
        (SELECT COUNT(*) FROM accounts WHERE income < 20000) AS accounts_count
UNION ALL 
SELECT 'Average Salary'  AS category,
        (SELECT COUNT(*) FROM accounts WHERE income BETWEEN 20000 AND 50000) 
UNION ALL 
SELECT 'High Salary' AS category,
        (SELECT COUNT(*) FROM accounts WHERE income > 50000) 


-- note 
-- this wont work
-- there is no account_id with salary as Average Salary,
--  the cte wont return 'Average Salary' as a category. 
-- So, when we group by category, 
-- there is no such category as 'Average Salary' to result in output.
WITH salary_category AS( SELECT 
                        CASE WHEN income < 20000 THEN 'Low Salary' 
                             WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary' 
                             WHEN income > 50000 THEN 'High Salary'
                            ELSE 0
                        END AS category 
                        FROM accounts)
SELECT category, COUNT(*) AS accounts_count
FROM salary_category 
GROUP BY category

-- to fix that, we need another cte to identify the category
-- then left join, to include all salary categories
-- but this is slow 
-- 78.39%
WITH salary_category AS( SELECT account_id, 
                        CASE WHEN income < 20000 THEN 'Low Salary' 
                             WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary' 
                             WHEN income > 50000 THEN 'High Salary'
                            ELSE 0
                        END AS category 
                        FROM accounts),
salary AS(
SELECT 'Low Salary' AS category
UNION ALL 
SELECT 'High Salary'AS category
UNION ALL 
SELECT 'Average Salary' AS category)


SELECT s.category, 
        IFNULL(COUNT(account_id), 0) AS accounts_count
FROM salary s
LEFT JOIN salary_category c
ON s.category = c.category
GROUP BY category

----------------------------------------------------------------------------------------
-- Active Users
-- https://leetcode.com/problems/active-users/

-- 91.46 %
WITH consecutive_days AS (
    select id, login_date as day0, 
                                 lead(login_date, 4) over (partition by id order by login_date) as day4  
    from (select distinct id, login_date from logins) t1)
SELECT DISTINCT a.id, name
FROM accounts a, consecutive_days c
WHERE a.id = c.id 
AND datediff(day4, day0)=4 #diff = 4 so it is consecutive
                # with diff >= 4 we cannot make sure it is consecutive
                # we only use LEAD(login_date, 4)
ORDER BY id

-- Some notes:
-- When question asked to find consecuties, think about self join
-- 5 consecutives days LEAD(login_date, 4)
-- 3 consecutives days LEAD(login_date, 2)