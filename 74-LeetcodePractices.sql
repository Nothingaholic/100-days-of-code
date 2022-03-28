-- Number of Calls Between Two Persons
-- https://leetcode.com/problems/number-of-calls-between-two-persons/


-- 67.73%
SELECT CASE WHEN from_id < to_id THEN from_id
            ELSE to_id END AS person1,
       CASE WHEN from_id > to_id THEN from_id
            ELSE to_id END AS person2, 
       COUNT(1) AS call_count,
       SUM(duration) as total_duration
FROM calls
GROUP BY person1, person2

-- 85.27%
WITH call_info AS ( SELECT from_id, to_id, duration 
                            FROM calls
                            WHERE from_id < to_id
                    UNION ALL 
                    SELECT to_id, from_id, duration 
                            FROM calls
                            WHERE to_id < from_id)
SELECT from_id AS person1,
        to_id AS person2,
        COUNT(from_id) AS call_count,
        SUM(duration) AS total_duration
FROM call_info    
GROUP BY from_id, to_id
----------------------------------------------------------------------------------------
--  Countries You Can Safely Invest In
-- https://leetcode.com/problems/countries-you-can-safely-invest-in/

-- 99.57%
-- query to identify callers and duration for each call
WITH call_info AS (SELECT 
                    caller_id as caller,
                    duration
                 FROM calls
                 UNION ALL 
                 SELECT
                    callee_id as caller,
                    duration
                 FROM calls),
-- user information, inclduing caller_id and country, duration for each call                 
user_info AS (
                    SELECT id, c.name as country, ci.duration
                    FROM call_info ci
                    JOIN person p
                        ON p.id = ci.caller
                    LEFT JOIN country c
                        ON SUBSTR(phone_number, 1, 3) = c.country_code),
-- find the average call duration  for each country                      
avg_duration AS(
                SELECT country, AVG(duration) AS duration_per_country
                FROM user_info
                GROUP BY country)

SELECT country
FROM avg_duration
WHERE duration_per_country > (SELECT AVG(duration) FROM user_info)
----------------------------------------------------------------------------------------
-- Calculate Special Bonus
-- https://leetcode.com/problems/calculate-special-bonus/
--67.11%
WITH bonuses AS (
                    SELECT employee_id, salary as bonus
                    FROM employees 
                    WHERE employee_id % 2 = 1
                    AND name NOT LIKE 'M%')
SELECT e.employee_id, IFNULL(bonus,0) as bonus
FROM employees e
LEFT JOIN bonuses b
ON e.employee_id = b.employee_id

-- 99.01%
SELECT employee_id, 
        CASE WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary
                ELSE 0 END as bonus
FROM employees 
----------------------------------------------------------------------------------------
-- Calculate Salaries
-- https://leetcode.com/problems/calculate-salaries/

-- 94.14%
WITH tax_rate AS (
                SELECT company_id,
                        CASE WHEN MAX(salary) BETWEEN 1000 AND 10000 THEN  0.24
                            WHEN MAX(salary) > 10000 THEN  0.49
                            ELSE 0 END as rate
                FROM salaries
                GROUP BY company_id)
                
SELECT s.company_id, employee_id, employee_name, ROUND(salary - salary * rate) as salary
FROM salaries s, tax_rate t
WHERE s.company_id = t.company_id
----------------------------------------------------------------------------------------
-- Average Salary: Departments VS Company
-- https://leetcode.com/problems/average-salary-departments-vs-company/

-- 97.35%
WITH department AS (
                    SELECT s.employee_id, amount, SUBSTR(pay_date, 1, 7) as pay_month, department_id
                    FROM salary s, employee e
                    WHERE s.employee_id = e.employee_id
                    ),
avg_month AS ( 
                SELECT pay_month, AVG(amount) as per_month
                FROM department
                GROUP BY pay_month),
avg_department AS ( 
                SELECT pay_month, department_id, AVG(amount) as per_dept
                FROM department
                GROUP BY department_id, pay_month)
SELECT d.pay_month, 
        d.department_id,
        CASE WHEN per_dept > per_month THEN 'higher'
             WHEN per_dept = per_month THEN 'same'
             ELSE 'lower' END AS comparison
FROM avg_department d, avg_month m
WHERE d.pay_month = m.pay_month