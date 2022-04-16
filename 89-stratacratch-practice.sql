-- Customer Revenue In March
-- https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?python=

SELECT cust_id,
    SUM(total_order_cost) as revenue
FROM orders
WHERE order_date BETWEEN '2019-03-01' AND '2019-03-31'
GROUP BY cust_id
ORDER BY revenue DESC

----------------------------------------------------------------------------------------  
-- Highest Target Under Manager
-- https://platform.stratascratch.com/coding/9905-highest-target-under-manager?python=

SELECT first_name, target
FROM salesforce_employees
WHERE manager_id = 13
AND target in (SELECT MAX(target)
                FROM salesforce_employees
                WHERE manager_id = 13);
----------------------------------------------------------------------------------------  
-- Highest Salary In Department
-- https://platform.stratascratch.com/coding/9897-highest-salary-in-department?python= 
SELECT department, 
        first_name as employee_name, 
        salary
FROM employee
WHERE salary IN (SELECT MAX(salary)
                    FROM employee
                    GROUP BY department)
GROUP BY department, first_name, salary
ORDER BY salary DESC
----------------------------------------------------------------------------------------  
-- Employee and Manager Salaries
-- https://platform.stratascratch.com/coding/9894-employee-and-manager-salaries?python=

SELECT e1.first_name as employee_name,
        e1.salary as employee_salary
FROM employee e1, employee e2
WHERE e1.manager_id = e2.id
AND e1.salary > e2.salary

----------------------------------------------------------------------------------------  
-- Ranking Most Active Guests
-- https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?python=


SELECT DENSE_RANK() OVER(ORDER BY SUM(n_messages) DESC) AS ranking,
    id_guest,
    SUM(n_messages) as sum_n_messages
FROM airbnb_contacts
GROUP BY id_guest
ORDER BY sum_n_messages DESC
