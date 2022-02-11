-- Stratascratch
-- MEta/Facebook Practice Questions

/* 
Calculate each user's average session time. A session is defined as the time difference 
between a page_load and page_exit. For simplicity, assume a user has only 1 session per day 
and if there are multiple of the same events on that day, consider only the latest page_load 
and earliest page_exit. Output the user_id and their average session time.

Table: facebook_web_log

+------------------+------------+
| user_id          | int        | 
+------------------+------------+
| timestamp        | datetime   | 
+------------------+------------+
| action           | varchar    | 
+------------------+------------+


*/


SELECT user_id, avg(session) AS "average_session_time"
FROM 
( SELECT t1.user_id, 
        date(t1.timestamp) AS dt,
        min(t2.timestamp) - max(t1.timestamp) AS session
    from facebook_web_log t1
    LEFT JOIN facebook_web_log t2
    ON t1.user_id = t2.user_id
    WHERE t1.action = 'page_load'
    AND t2.action = 'page_exit'
    AND date(t1.timestamp) = date(t2.timestamp)
    GROUP BY t1.user_id, date(t1.timestamp)
) a 
GROUP BY user_id;