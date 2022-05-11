/*
Find Median Given Frequency of Numbers
https://leetcode.com/problems/find-median-given-frequency-of-numbers/
*/

WITH freq AS (
    SELECT
            *,
            SUM(frequency) OVER (ORDER BY num ASC) AS idx, # index for each num
            SUM(frequency) OVER () / 2 as med # median index
        FROM 
            Numbers)
SELECT ROUND(AVG(num),2) as median
FROM freq
WHERE idx BETWEEN med  AND med + frequency

------------------------------------------------------------------------------
-- Tournament Winners
-- https://leetcode.com/problems/tournament-winners/
# Write your MySQL query statement below
WITH info AS (
                SELECT first_player as player,
                        first_score as score
                FROM matches
                UNION ALL
                SELECT second_player as player,
                        second_score as score
                FROM matches
    ),
score_info AS (
        SELECT group_id, p.player_id, SUM(score) as score
        FROM players p, info 
        WHERE p.player_id = player
        GROUP BY group_id, p.player_id),
rnk_info AS (
        SELECT *, 
            RANK() OVER(PARTITION BY group_id ORDER BY score DESC) as rnk
        FROM score_info)

SELECT group_id, player_id
FROM rnk_info
WHERE rnk = 1
GROUP BY group_id

