-- Find the Subtasks That Did Not Execute
-- https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/
-- https://medium.com/swlh/recursion-in-sql-explained-graphically-679f6a0f143b

with RECURSIVE sub_task as
(
SELECT task_id, 1 as sub_count FROM tasks # base, start from 1
UNION 
SELECT s.task_id, sub_count + 1 
    FROM sub_task s, tasks t # join with tasks table to get the subtasks_count
    WHERE s.task_id = t.task_id
    AND sub_count < subtasks_count) # stop when reach max(subtasks_count)

# SELECT * FROM sub_task
SELECT task_id, sub_count AS subtask_id
FROM sub_task
WHERE (task_id, sub_count) NOT IN (SELECT task_id, subtask_id
                                    FROM executed)
----------------------------------------------------------------------------------------  
-- Sales by Day of the Week
-- https://leetcode.com/problems/sales-by-day-of-the-week/


WITH info AS (SELECT order_date, o.item_id, IFNULL(sum(quantity),0) as quantity, item_category AS Category
FROM orders o
RIGHT JOIN items i
ON o.item_id = i.item_id
GROUP BY order_date, item_id)

SELECT Category, 
SUM(CASE WHEN DAYNAME(order_date) = 'Monday' then quantity ELSE 0 END) AS Monday,
SUM(CASE WHEN DAYNAME(order_date) = 'Tuesday' then quantity ELSE 0 END) AS Tuesday,
SUM(CASE WHEN DAYNAME(order_date) = 'Wednesday' then quantity ELSE 0 END) AS Wednesday,
SUM(CASE WHEN DAYNAME(order_date) = 'Thursday' then quantity ELSE 0 END) AS Thursday,
SUM(CASE WHEN DAYNAME(order_date) = 'Friday' then quantity ELSE 0 END) AS Friday,
SUM(CASE WHEN DAYNAME(order_date) = 'Saturday' then quantity ELSE 0 END) AS Saturday,
SUM(CASE WHEN DAYNAME(order_date) = 'Sunday' then quantity ELSE 0 END) AS Sunday
FROM info
GROUP BY category
ORDER BY category
----------------------------------------------------------------------------------------  
 -- Number of Calls Between Two Persons
 -- https://leetcode.com/problems/number-of-calls-between-two-persons/
 -- SQL II day 1 ( Numerical Processing Functions)

 WITH info AS (
                SELECT from_id as person1, to_id as person2, duration FROM calls
                UNION ALL
                SELECT to_id as person1, from_id as person2, duration FROM calls)
                
SELECT person1, person2, 
        COUNT(person1) as call_count,
        SUM(duration) as total_duration
FROM info
WHERE person1 < person2
GROUP BY person1, person2