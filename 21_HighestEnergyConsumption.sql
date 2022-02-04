-- Stratascratch
-- Meta/Facebook Interview Questions
/*

Find the date with the highest total energy consumption 
from the Meta/Facebook data centers. 
Output the date along with the total energy consumption across all data centers.

Tables: fb_eu_energy, fb_asia_energy, fb_na_energy
fb_eu_energy
+--------------+---------+
| datedate     | time    |
+--------------+---------+
| consumption  | int     |
+--------------+---------+


fb_asia_energy
+--------------+---------+
| datedate     | time    |
+--------------+---------+
| consumption  | int     |
+--------------+---------+


fb_na_energy
+--------------+---------+
| datedate     |  time   |
+--------------+---------+
| consumption  |  int    |
+--------------+---------+

*/

-- create a list of dates and consumption values from all FB data centers using a UNION ALL
-- sum energy and group by date
-- identify the max energy consumption
-- join the max energy with energy consumption by date, we can find the date of max energy.
--  This handles the case where there might be multiple dates with max energy consumption

SELECT date, 
        total_energy 
        FROM (
            SELECT date, 
            SUM(consumption) AS total_energy, 
            RANK() OVER (ORDER BY SUM(consumption) DESC) AS r 
            FROM (
                SELECT * FROM fb_eu_energy
                UNION ALL
                SELECT * FROM fb_asia_energy
                UNION ALL
                SELECT * FROM fb_na_energy
                ) fb_energy
            GROUP BY date
            ) fb_energy_ranked
        WHERE r = 1