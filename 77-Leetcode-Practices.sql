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
-- 
----------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------
-- 