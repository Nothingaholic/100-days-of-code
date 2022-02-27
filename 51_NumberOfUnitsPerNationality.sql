-- Stratascratch
-- Airbnb
-- Medium

/* 

Find the number of apartments per nationality that are owned by people under 30 years old.
Output the nationality along with the number of apartments.
Sort records by the apartments count in descending order.

airbnb_hosts
+---------------+------------+
| host_id       | int        | 
+---------------+------------+
| nationality   |    varchar |
+---------------+------------+
| gender        |    varchar |
+---------------+------------+
| age           | int        |
+---------------+------------+

airbnb_units 
+---------------+------------+
| host_id       | int        |
+---------------+------------+
| unit_id       | varchar    |
+---------------+------------+
| unit_type     | varchar    |
+---------------+------------+
| n_beds        | int        |
+---------------+------------+
| n_bedrooms    | int        |
+---------------+------------+
| country       | varchar    |
+---------------+------------+
| city          | varchar    |
+---------------+------------+



*/
SELECT nationality, count(*)
FROM airbnb_hosts h, airbnb_units u
WHERE h.host_id = u.host_id
AND unit_type = 'Apartment'
AND age < 30
GROUP BY nationality;