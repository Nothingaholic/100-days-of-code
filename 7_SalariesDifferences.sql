-- Stratascratch
-- Dropbox Interview Questions
/* 
Write a query that calculates the difference between the highest salaries 
found in the marketing and engineering departments. 
Output just the absolute difference in salaries.

Tables: db_employee, db_dept
db_employee
id              int
first_name      varchar
last_name       varchar
salary          int
department_id   int

db_dept
id              int
department      varchar
 */


SELECT 
ABS((
(SELECT max(salary) from db_employee
    JOIN db_dept ON  db_dept.id = db_employee.department_id
    WHERE department = 'marketing')
    - 
(SELECT max(salary) from db_employee
    JOIN db_dept ON db_dept.id = db_employee.department_id
    WHERE department = 'engineering')
)) AS salary_difference;
