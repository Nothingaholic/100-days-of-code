-- Stratescratch
-- Airbnb 
-- medium level

/* 

Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.
Table:airbnb_hosts, airbnb_guests

airbnb_hosts

+------------------+------------+
| host_id          | int        | 
+------------------+------------+
| nationality      | varchar    | 
+------------------+------------+
| gender           | varchar    | 
+------------------+------------+
| age              | int        | 
+------------------+------------+

airbnb_guests
+------------------+------------+
| guest_id         | int        | 
+------------------+------------+
| nationality      | varchar    | 
+------------------+------------+
| gender           | varchar    | 
+------------------+------------+
| age              | int        | 
+------------------+------------+
*/

SELECT h.host_id,
       g.guest_id
FROM airbnb_hosts h
INNER JOIN airbnb_guests g
ON
    h.nationality = g.nationality
    AND h.gender = g.gender
;