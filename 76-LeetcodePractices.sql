-- The Number of Passengers in Each Bus I
-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/

WITH buses_info AS ( SELECT *, 
                LAG(arrival_time,1,0) OVER (ORDER BY arrival_time) as pre_bus
                FROM buses)
            
SELECT bus_id, COUNT(p.arrival_time) AS passengers_cnt
FROM buses_info b
LEFT JOIN passengers p
ON p.arrival_time <= b.arrival_time
AND p.arrival_time > b.pre_bus
GROUP BY bus_id, b.arrival_time
ORDER BY bus_id
              
----------------------------------------------------------------------------------------
--  Exchange Seats
-- https://leetcode.com/problems/exchange-seats/


WITH s2 AS ( SELECT id, LEAD(student,1, student) OVER() even_student,
                LAG(student,1,student) OVER() odd_student
                FROM seat)

SELECT s1.id, 
    CASE WHEN s1.id % 2 = 1 THEN s2.even_student
        ELSE s2.odd_student END 
        AS student
FROM seat s1, s2
WHERE s1.id = s2.id


SELECT 
        CASE WHEN id % 2 = 0 THEN id -1 -- swap with the row above
            WHEN id % 2 = 1 AND (SELECT MAX(id) FROM seat) != id -- odd id, but not the last row
                THEN id + 1
            ELSE id -- the last row 
        END as id,
        student
FROM seat
ORDER BY id
----------------------------------------------------------------------------------------
-- Confirmation Rate
-- https://leetcode.com/problems/confirmation-rate/

-- 96.61%
-- count how many comfimred action for each user
WITH confirm AS ( SELECT user_id, COUNT(action) as confirmed
                   FROM confirmations 
                   WHERE action = 'confirmed' 
                   GROUP BY user_id
                ),
-- calcualte the confirmation_rate
 conf_rate  AS ( SELECT c1.user_id,
                    ROUND(confirmed/ COUNT(action),2) as confirmation_rate
                FROM confirmations c1, confirm c2
                WHERE c1.user_id = c2.user_id
                GROUP BY c1.user_id)            
-- left join signeups table with conf_rate to get user_id
SELECT s.user_id, IFNULL(confirmation_rate,0) as confirmation_rate
FROM signups s
LEFT JOIN conf_rate c
ON s.user_id = c.user_id



-- or 
-- CTE to get information of each user (id, action)
WITH info  AS ( SELECT s.user_id, action
               FROm signups s
               LEFT JOIN confirmations c
               ON s.user_id = c.user_id)
              
-- calculate the confirmation_rate     
SELECT user_id, 
    ROUND(AVG(CASE WHEN action = 'confirmed' THEN 1
                ELSE 0 END) ,2) AS confirmation_rate
FROM info
GROUP BY user_id

----------------------------------------------------------------------------------------
-- Patients With a Condition
-- https://leetcode.com/problems/patients-with-a-condition/
SELECT * FROM patients
WHERE conditions LIKE '% DIAB1%' OR conditions LIKE 'DIAB1%'
----------------------------------------------------------------------------------------
-- Employees Whose Manager Left the Company
-- https://leetcode.com/problems/employees-whose-manager-left-the-company/

SELECT employee_id 
FROM employees
WHERE salary < 30000
AND manager_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id