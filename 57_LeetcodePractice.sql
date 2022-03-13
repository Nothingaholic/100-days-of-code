-- Rising Temperature
-- https://leetcode.com/problems/rising-temperature/

SELECT w2.id
FROM weather w1, weather w2
WHERE  w2.temperature > w1.temperature
AND DATEDIFF(w2.recordDate, w1.recordDate) = 1
----------------------------------------------------------------------------------------

-- Game Play Analysis I
-- First time login
-- https://leetcode.com/problems/game-play-analysis-i/

-- won't work, will miss people if they only login 1
SELECT a1.player_id, a1.event_Date as first_login
FROM activity a1, activity a2
WHERE a1.player_id = a2.player_id
AND a1.event_date < a2.event_date

SELECT player_id, min(event_Date) as first_login
FROM activity 
GROUP BY player_id
----------------------------------------------------------------------------------------
-- Game Play Analysis II
-- First device login
-- https://leetcode.com/problems/game-play-analysis-ii/


-- subquery to get the information of the first login date
-- now find information about the first time device login
SELECT player_id, device_id 
FROM activity
WHERE (player_id, event_date) IN (SELECT player_id, 
                                min(event_Date)
                        FROM activity 
                        GROUP BY player_id) 

----------------------------------------------------------------------------------------
-- Employee Bonus
-- https://leetcode.com/problems/employee-bonus/

-- LEFT JOIN bonus table, the new table will have information
-- of all employeea, who receive and who don't
-- from this table, we only want people with bonus < 1000 or 
-- don't receive any bonuses
SELECT e.name, b.bonus
FROM employee e
LEFT JOIN bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL 

----------------------------------------------------------------------------------------
-- Find Customer Referee
-- https://leetcode.com/problems/find-customer-referee/


-- from the customer table, we just want the rows where
-- referee_id is NULL or != 2
SELECT name
FROM customer
WHERE referee_id IS NULL 
OR referee_id != 2