-- Biggest Window Between Visits
--  https://leetcode.com/problems/biggest-window-between-visits/
WITH visit_list AS (SELECT user_id,  visit_date,
        IFNULL(LEAD(visit_Date, 1) OVER (PARTITION BY user_id ORDER BY visit_date),'2021-1-1') AS visit
FROM uservisits)

SELECT user_id, MAX(ABS(DATEDIFF(visit_date, visit))) biggest_window
FROM visit_list
GROUP BY user_id
ORDER BY user_id
----------------------------------------------------------------------------------------
-- Team Scores in Football Tournament
-- https://leetcode.com/problems/team-scores-in-football-tournament/

WITH host_team AS ( SELECT host_team, 
                    SUM(CASE WHEN host_goals > guest_goals THEN 3
                            WHEN host_goals = guest_goals THEN 1
                            ELSE 0 END) AS num_points
                    FROM Matches
                    GROUP BY host_team),
guest_team AS ( SELECT guest_team, 
                    SUM(CASE WHEN host_goals > guest_goals THEN 0
                            WHEN host_goals = guest_goals THEN 1
                            ELSE 3 END) AS num_points
                    FROM Matches
                    GROUP BY guest_team)
SELECT t.team_id, team_name, IFNULL(h.num_points,0) + IFNULL(g.num_points,0) as num_points
FROM teams t 
LEFT JOIN host_team h
ON t.team_id = h.host_team
LEFT JOIN guest_team g
ON t.team_id = g.guest_team
ORDER BY num_points DESC, t.team_id

-- faster 
WITH team_points as (SELECT team as 'team_id', SUM(score) as 'num_points'
                    FROM
                     -- host_team
                    (SELECT host_team as team,
                    CASE WHEN host_goals > guest_goals THEN 3
                    WHEN host_goals = guest_goals THEN 1
                    ELSE 0 END as 'score'
                    FROM Matches
                     
                    UNION ALL
                     
                     -- guest_team
                    SELECT guest_team as team,
                    CASE WHEN host_goals > guest_goals THEN 0
                    WHEN host_goals = guest_goals THEN 1
                    ELSE 3 END as 'score'
                    FROM Matches) as x
                    GROUP BY team)

SELECT t.team_id, t.team_name, IFNULL(num_points,0) as num_points
FROM Teams as t
LEFT JOIN team_points p
ON t.team_id = p.team_id
ORDER BY num_points DESC, t.team_id
----------------------------------------------------------------------------------------
-- Strong Friendship
-- https://leetcode.com/problems/strong-friendship/


-- get a friend list for all user so it will be easier to join
WITH friends AS (
    SELECT user1_id AS user, user2_id AS friend FROM Friendship 
    UNION ALL 
    select user2_id AS user, user1_id AS friend FROM Friendship 
), 
-- join to get user1_id, user2_id, user1_friends, user2_friends
common_friend AS(
SELECT f.user1_id, f.user2_id, 
     f1.friend AS user1_friends, f2.friend AS user2_friends
    
FROM friendship f, friends f1, friends f2
WHERE f.user1_id = f1.user  # user1's information
AND f.user2_id = f2.user    # user2's information
AND f1.friend = f2.friend  # common friend (user1's friend = user2's friend)
)
-- count>=3  (at least three common friend) to get strong friendship
SELECT user1_id, user2_id, COUNT(*) as common_friend
from common_friend

GROUP BY user1_id, user2_id
HAVING COUNT(*) >= 3
----------------------------------------------------------------------------------------
-- Running Total for Different Genders
-- https://leetcode.com/problems/running-total-for-different-genders/

SELECT gender, day,
        SUM(score_points) OVER(PARTITION BY GENDER ORDER BY day) AS total
FROM scores
ORDER BY gender, day
----------------------------------------------------------------------------------------
-- Number of Trusted Contacts of a Customer
-- https://leetcode.com/problems/number-of-trusted-contacts-of-a-customer/


WITH contact_count AS (
                    SELECT customer_id, customer_name,
                    COUNT(contact_name) AS contacts_cnt
                    FROM customers
                    LEFT JOIN contacts 
                    ON customer_id = user_id
                    GROUP BY customer_id),
trusted_contact AS (SELECT user_id, COUNT(contact_name) AS trusted_contacts_cnt
                    FROM contacts
                 WHERE contact_name IN (SELECT customer_name FROM customers)
                   GROUP BY user_id)
SELECT invoice_id, c.customer_name,
    price, IFNULL(contacts_cnt,0) AS contacts_cnt,
    IFNULL(trusted_contacts_cnt,0) AS trusted_contacts_cnt
FROM invoices i

LEFT JOIN contact_count c
ON  i.user_id = c.customer_id

LEFT JOIN  trusted_contact t
ON i.user_id = t.user_id

ORDER BY invoice_id