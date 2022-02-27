-- Stratascratch
-- YElp
-- Medium

/* 

Find the top 5 businesses with most reviews. 
Assume that each row has a unique business_id such that the total reviews
 for each business is listed on each row. Output the business name along 
 with the total number of reviews and order your results by the total reviews in descending order.

yelp_business
+---------------+------------+
| business_id   |    varchar |
+---------------+------------+
| name          |    varchar |
+---------------+------------+
| neighborhood  |    varchar |
+---------------+------------+
| address       |    varchar |
+---------------+------------+
| city          |    varchar |
+---------------+------------+
| state         |    varchar |
+---------------+------------+
| postal_code   |    varchar |
+---------------+------------+
| latitude      |   float    |
+---------------+------------+
| longitude     |   float    |
+---------------+------------+
| stars         |   float    |
+---------------+------------+
| review_count  |    int     |
+---------------+------------+
| is_open       |    int     |
+---------------+------------+
| categories    |    varchar |
+---------------+------------+


*/

select 
    name,
    review_count
from yelp_business
where
    review_count in 
    (select distinct review_count 
    from yelp_business 
    order by review_count desc
    limit 5)
order by review_count desc