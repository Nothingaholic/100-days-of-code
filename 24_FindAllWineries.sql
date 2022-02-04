-- Stratascratch
-- Wine Magazine Practice Questions

/*

Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut.
Output unique winery values only.

Table: winemag_p1


+-------------------+------------+
| id                | int        | 
+-------------------+------------+
| country           | varchar    |  
+-------------------+------------+
| description       | varchar    | 
+-------------------+------------+
| designation       | varchar    | 
+-------------------+------------+
| points            | int        | 
+-------------------+------------+
| price             | float      | 
+-------------------+------------+
| province          | varchar    | 
+-------------------+------------+
| region_1          | varchar    | 
+-------------------+------------+
| region_2          | varchar    |
+-------------------+------------+
| variety           | varchar    |
+-------------------+------------+
| winery            | varchar    |
+-------------------+------------+
*/

select winery 
from winemag_p1
where description ilike '%plum%'
or description ilike '%cherry%'
or description ilike '%rose%'
or description ilike '%hazelnut%';