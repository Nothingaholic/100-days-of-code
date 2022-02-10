-- Stratascratch
-- DoorDash Practice Questions

/* 
Find the titles of workers that earn the highest salary. 
Output the highest-paid title or multiple titles that share the highest salary.

Table: worker, title

worker
+------------------+------------+
| worker_id        | int        | 
+------------------+------------+
| first_name       | varchar    | 
+------------------+------------+
| last_name        | varchar    | 
+------------------+------------+
| salary           | int        | 
+------------------+------------+
| joining_date     | datetime   | 
+------------------+------------+
| department       | varchar    | 
+------------------+------------+

title
+------------------+------------+
| worker_ref_id    | int        | 
+------------------+------------+
| worker_title     | varchar    | 
+------------------+------------+
| affected_from    | datetime   |
+------------------+------------+ 

*/

SELECT worker_title AS "Best paid title"
FROM title 
LEFT JOIN worker 
ON worker.worker_id = title.worker_ref_id
WHERE salary = (SELECT max(salary) from worker);