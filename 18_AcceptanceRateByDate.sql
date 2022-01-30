-- Stratascratch
-- Meta Interview Questions

/*

What is the overall friend acceptance rate by date? 
Your output should have the rate of acceptances by the date the request was sent. 
Order by the earliest date to latest. 
Assume that each friend request starts by a user sending (i.e., user_id_sender) 
a friend request to another user (i.e., user_id_receiver) 
that's logged in the table with action = 'sent'. If the request is accepted, 
the table logs action = 'accepted'. If the request is not accepted, 
no record of action = 'accepted' is logged.

Table: fb_friend_requests

+------------------+------------+
| user_id_sender   | varchar    |
+------------------+------------+
| user_id_receiver | varchar    | 
+------------------+------------+
| date             | datetime   | 
+------------------+------------+
| action           | varchar    |
+------------------+------------+

*/

SELECT t1.date,
       count(t2.user_id_receiver) / count(t1.user_id_sender)::float    
       as acceptance_rate
FROM 
    (SELECT
          date,
          user_id_sender,
          user_id_receiver
    FROM fb_friend_requests
    WHERE action = 'sent') t1
left join 
    (SELECT
          date,
          user_id_sender,
          user_id_receiver
    FROM fb_friend_requests
    WHERE action = 'accepted') t2
on t2.user_id_sender = t1.user_id_sender
and t2.user_id_receiver = t1.user_id_receiver
group by t1.date;

