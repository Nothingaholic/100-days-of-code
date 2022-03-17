-- Average Selling Price
-- https://leetcode.com/problems/average-selling-price/submissions/


SELECT p.product_id,
        ROUND(SUM(price * units) / sum(units),2) as average_price
FROM prices p, unitssold u
WHERE p.product_id = u.product_id
AND purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id
----------------------------------------------------------------------------------------
-- User Activity for the Past 30 Days II
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-ii/
-- Netflix



-- wrong answer 
-- not consider null cases
SELECT ROUND(cast(count(activity_type) as float) / cast(count(DISTINCT user_id) as float), 2) average_sessions_per_user
FROM activity
WHERE activity_date > '2019-06-27'
AND activity_date <= '2019-07-27'
AND activity_type IN ('scroll_down', 'send_message')

-- wrong answer
-- to get the total number of session per user, count the session_id instead of 
-- counting the activity type
-- open then end is still consider 1 session.
SELECT IFNULL(ROUND(cast(count(activity_type) as float) / cast(count(DISTINCT user_id) as float), 2),0.00) average_sessions_per_user
FROM activity
WHERE activity_date > '2019-06-27'
AND activity_date <= '2019-07-27'
AND activity_type IN ('scroll_down', 'send_message')


--  The number of sessions divided by the number of users is the average, 
-- but also pay attention to whether it is a null value 
SELECT IFNULL(ROUND(COUNT(DISTINCT session_id) / COUNT(DISTINCT user_id), 2), 0) 
       AS average_sessions_per_user
FROM Activity
WHERE DATEDIFF('2019-07-27', activity_date) < 30


SELECT IFNULL(ROUND(COUNT(DISTINCT session_id) / COUNT(DISTINCT user_id), 2), 0) 
       AS average_sessions_per_user
FROM activity
WHERE activity_date > '2019-06-27'
AND activity_date <= '2019-07-27'
----------------------------------------------------------------------------------------
-- Reformat department table
-- https://leetcode.com/problems/reformat-department-table/
-- Amazon

select id, 
sum(case when month = 'Jan' then revenue else null end) Jan_Revenue,
sum(case when month = 'Feb' then revenue else null end) Feb_Revenue,
sum(case when month = 'Mar' then revenue else null end) Mar_Revenue,
sum(case when month = 'Apr' then revenue else null end) Apr_Revenue,
sum(case when month = 'May' then revenue else null end) May_Revenue,
sum(case when month = 'Jun' then revenue else null end) Jun_Revenue,
sum(case when month = 'Jul' then revenue else null end) Jul_Revenue,
sum(case when month = 'Aug' then revenue else null end) Aug_Revenue,
sum(case when month = 'Sep' then revenue else null end) Sep_Revenue,
sum(case when month = 'Oct' then revenue else null end) Oct_Revenue,
sum(case when month = 'Nov' then revenue else null end) Nov_Revenue,
sum(case when month = 'Dec' then revenue else null end) Dec_Revenue
from department
group by id;
----------------------------------------------------------------------------------------
-- Queries Quality and Percentage
-- https://leetcode.com/problems/queries-quality-and-percentage/


SELECT query_name,
ROUND(SUM(rating / position) / COUNT(*),2) as quality,
ROUND((SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) / COUNT(*))*100,2) as poor_query_percentage
FROM queries
GROUP BY query_name
----------------------------------------------------------------------------------------
-- Number of Comments per Post
-- https://leetcode.com/problems/number-of-comments-per-post/

-- missing post with no commnent
-- need a left join
SELECT s1.sub_id as post_id,
    COUNT(DISTINCT s2.sub_id) as number_of_comments
-- join the table with itself
FROM submissions s1, submissions s2
WHERE s1.sub_id = s2.parent_id -- posts that have comments
GROUP BY s1.sub_id


-- correct
SELECT s1.sub_id as post_id,
    COUNT(DISTINCT s2.sub_id) as number_of_comments

FROM submissions s1
LEFT JOIN submissions s2
ON s1.sub_id = s2.parent_id -- posts that have comments
WHERE s1.parent_id IS NULL -- left join, with condition that the 
                    -- parent_id is NULL
GROUP BY s1.sub_id