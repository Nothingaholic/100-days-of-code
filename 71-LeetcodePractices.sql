-- Get Highest Answer Rate Question
-- https://leetcode.com/problems/get-highest-answer-rate-question/
-- 69.45%

WITH answer_rate AS(
                        SELECT question_id, (COUNT(answer_id) / COUNT(question_id)) AS rate
                        FROM surveylog
                        GROUP BY question_id
                        ORDER BY rate DESC, question_id)
    
SELECT question_id as survey_log
FROM answer_rate
LIMIT 1

-- 95.44%
SELECT question_id as survey_log
FROM surveylog
GROUP BY question_id
ORDER BY (COUNT(answer_id)/count(question_id)) DESC
LIMIT 1
----------------------------------------------------------------------------------------
--  Invalid Tweets
-- https://leetcode.com/problems/invalid-tweets/

-- 97.32%
SELECT tweet_id
FROM tweets
WHERE LENGTH(content) > 15
----------------------------------------------------------------------------------------
-- Daily Leads and Partners
-- https://leetcode.com/problems/daily-leads-and-partners/


-- 64.01% 
SELECT date_id, make_name, COUNT(DISTINCT lead_id) as unique_leads,
        COUNT(DISTINCT partner_id) AS unique_partners
FROM dailysales
GROUP BY date_id, make_name

----------------------------------------------------------------------------------------
--  The Number of Employees Which Report to Each Employee
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/

--93.05%
SELECT e1.employee_id,
        e1.name,
        COUNT(e1.employee_id) AS reports_count,
        ROUND(IFNULL(AVG(e2.age), 0))  AS average_age
FROM employees e1, employees e2
WHERE e1.employee_id = e2.reports_to
Group by e1.employee_id, e1.name
Order by e1.employee_id
----------------------------------------------------------------------------------------
--   Managers with at Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

-- 45.25%
-- CTE to get information of the manager who has at least 5 direct reports
WITH manager AS (
                    SELECT e2.managerid, count(e2.managerid) AS count_report
                    FROM employee e1, employee e2
                    WHERE e1.id = e2.managerid -- employee report to manager
                    GROUP BY e2.managerid
                    HAVING count_report >= 5)
SELECT name
FROM employee
WHERE id IN (SELECT managerid FROM manager)

-- 82.35%
SELECT e1.name
FROM employee e1, employee e2
WHERE e1.id = e2.managerid -- employee report to manager
GROUP BY e2.managerid
HAVING count(e2.managerid) >= 5


-- 89.03% 
SELECT name
FROM employee
WHERE id IN (SELECT managerid FROM employee
             WHERE managerid IS NOT NULL
            GROUP BY managerid
            HAVING count(managerid) >= 5)