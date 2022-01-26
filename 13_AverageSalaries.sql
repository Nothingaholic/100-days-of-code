-- Stratascratch
-- Salesforce Interview Questions

/* 
Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees 
along with the average salary of that department.

Table: employee
id                      int
first_name              varchar
last_name               varchar
age                     int
sex                     varchar
employee_title          varchar
department              varchar
salary                  int
target                  int
bonus                   int
email                   varchar
city                    varchar
address                 varchar
manager_id              int

*/

select e1.department,
        e1.first_name,
        e1.salary,
        e2.avg_salary
        from employee e1
left join (select department, 
            avg(salary) as avg_salary 
            from employee 
            group by department) e2
    on e2.department = e1.department;