-- Customer Placing the Largest Number of Orders
-- https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/submissions/

-- count total number of orders for each customer 
SELECT COUNT(order_number)
FROM orders
GROUP BY customer_number

-- want to select customer_number who has the largest number of orders
SELECT customer_number
FROM orders
GROUP BY customer_number -- each customer can make many orders.
                        -- group by customer_number
                        -- with the condition that they make the largest number of orders
HAVING COUNT(order_number) >= ALL (SELECT COUNT(order_number)
                                FROM orders
                                GROUP BY customer_number)

----------------------------------------------------------------------------------------
-- Big Countries
-- https://leetcode.com/problems/big-countries/

SELECT name, population, area
FROM world
WHERE area >= 3000000 
OR population >= 25000000
----------------------------------------------------------------------------------------
-- CLasses more than 5 Students
-- https://leetcode.com/problems/classes-more-than-5-students/


SELECT class
FROM courses
GROUP BY class
HAVING count(class) >=5;
----------------------------------------------------------------------------------------
-- Friend Requests I: Overall Acceptance Rate
-- https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

-- select distinct sender_id and send_to_id
SELECT DISTINCT sender_id, send_to_id FROM friendrequest fr
 -- count the total number send_request
SELECT COUNT(*) 
FROM (SELECT DISTINCT sender_id, send_to_id FROM friendrequest) AS request;
-- count the total number of accecpted_request
SELECT COUNT(*) 
FROM (SELECT DISTINCT requester_id, accepter_id FROM requestaccepted ) accecpted; 

-- The accept_rate = the number of acceptance divided by the number of requests.
SELECT ROUND(
(SELECT COUNT(*) 
FROM (SELECT DISTINCT requester_id, accepter_id FROM requestaccepted ) accecpted)

/ 
 (SELECT COUNT(*) 
 FROM (SELECT DISTINCT sender_id, send_to_id FROM friendrequest)  request)

, 2) as accept_rate;

-- If there are no requests at all,  return 0.00 as the accept_rate.
SELECT ROUND(
IFNULL (
        (SELECT COUNT(*) 
FROM (SELECT DISTINCT requester_id, accepter_id FROM requestaccepted ) accecpted)

/ 
 (SELECT COUNT(*) 
 FROM (SELECT DISTINCT sender_id, send_to_id FROM friendrequest)  request)
,0)
, 2) as accept_rate;
----------------------------------------------------------------------------------------
--  Consecutive Available Seats
-- https://leetcode.com/problems/consecutive-available-seats/

-- all the consecutive available seats in the cinema
-- need to join table with itself.
-- abs(c1.seat_id - c2.seat_id) = 1 ( to get seat next to each other)
-- AND c1.free = 1 AND c2.free = 1 ( only select available seat)
/* 
TEST CASE
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
*/
SELECT DISTINCT c1.seat_id -- need distinct in case there are >= consecutive seat, 
                -- for example 3 4 5, seat #4 will appear twice
FROM cinema c1, cinema c2
WHERE ABS(c1.seat_id - c2.seat_id) = 1
AND c1.free = 1 and c2.free = 1 
ORDER BY c1.seat_id -- without this, it will print out 4 3 5 

-- note 
-- this won't work
-- it will miss the last seat (seat 5)
SELECT DISTINCT c1.seat_id
FROM cinema c1, cinema c2
WHERE c1.seat_id = c2.seat_id - 1 -- c1.seat4 = c2.seat5-1
AND c1.free = 1 AND c2.free = 1 -- true
ORDER BY c1.seat_id