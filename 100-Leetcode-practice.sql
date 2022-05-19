--Human Traffic of Stadium
-- https://leetcode.com/problems/human-traffic-of-stadium/


WITH consecutive_id AS ( 
            SELECT *, ROW_NUMBER() OVER(ORDER BY id) AS num
                FROM stadium
                WHERE people >= 100),
info AS ( SELECT id, people, visit_date,
            COUNT(id-num) OVER(PARTITION BY id-num) AS group_ppl
            FROM consecutive_id)
SELECT id, visit_date, people
FROM info
WHERE group_ppl >= 3
ORDER BY visit_date 

---------------------------------------------------------------------------
-- Count Apples and Oranges
-- https://leetcode.com/problems/count-apples-and-oranges/
WITH info AS(
            SELECT box_id, 
                IFNULL(b.apple_count+c.apple_count, b.apple_count) AS apple,
                IFNULL(b.orange_count+c.orange_count,b.orange_count) AS orange

        FROM boxes b
        LEFT JOIN chests c
        ON b.chest_id = c.chest_id)
SELECT SUM(apple) AS apple_count,
        SUM(orange) AS orange_count
    FROM info


---------------------------------------------------------------------------
-- Number of Accounts That Did Not Stream
-- https://leetcode.com/problems/number-of-accounts-that-did-not-stream/

WITH stream_info AS (
                    SELECT account_id
                    FROM streams
                    WHERE year(stream_date) != 2021)
SELECT COUNT(i.account_id) AS accounts_count
FROM subscriptions s, stream_info i
WHERE s.account_id = i.account_id
AND year(end_date) = 2021