-- Stratascratch
-- Amazon Interview Questions
/*

Write a query that'll identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days 
of any other of their purchases. Output a list of user_ids of these returning active users.
+--------------+---------+
| id           | int     | 
+--------------+---------+
| user_id      | int     |
+--------------+---------+ 
| item         | varchar |
+--------------+---------+
| created_at   | datetime| 
+--------------+---------+ 
| revenue      | int     |
+--------------+---------+
*/


select distinct t1.user_id
from amazon_transactions t1
inner join amazon_transactions t2
on t1.user_id = t2.user_id
where t1.id != t2.id
and t1.created_at - t2.created_at between 0 and 7
order by t1.user_id;