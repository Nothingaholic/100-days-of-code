-- Primary Department for Each Employee
-- https://leetcode.com/problems/primary-department-for-each-employee/

-- all employees with their primary department
SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'

UNION 
-- employee who belongs to only 1 department
SELECT employee_id, department_id
FROM employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1
----------------------------------------------------------------------------------------
-- Top Travellers
-- https://leetcode.com/problems/top-travellers/

SELECT name, IFNULL(SUM(distance),0) AS travelled_distance
FROM users u
LEFT JOIN rides r
ON u.id = user_id
GROUP BY u.id
ORDER BY travelled_distance DESC, name 
----------------------------------------------------------------------------------------
-- Market Analysis I
-- https://leetcode.com/problems/market-analysis-i/

SELECT 
        user_id as buyer_id, 
        join_date, 
        COUNT(buyer_id) AS orders_in_2019

FROM 
    users
LEFT JOIN 
    orders
ON 
    user_id = buyer_id
AND 
    order_date LIKE '2019%'
GROUP BY 
    user_id
----------------------------------------------------------------------------------------
-- Accepted Candidates From the Interviews
-- https://leetcode.com/problems/accepted-candidates-from-the-interviews/

SELECT 
    candidate_id
FROM 
    candidates c, rounds r
WHERE 
    c.interview_id = r.interview_id
AND 
    years_of_exp >= 2
GROUP BY 
    c.interview_id
HAVING 
    SUM(score) > 15
----------------------------------------------------------------------------------------
-- Unique Orders and Customers Per Month
-- https://leetcode.com/problems/unique-orders-and-customers-per-month/
SELECT 
        SUBSTRING(order_date, 1, 7) AS month, 
        COUNT(*) AS order_count,
        COUNT(DISTINCT customer_id) AS customer_count
        
FROM orders
WHERE invoice > 20
GROUP BY month