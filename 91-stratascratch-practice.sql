
-- Top 5 States With 5 Star Businesses
-- https://platform.stratascratch.com/coding/10046-top-5-states-with-5-star-businesses?python=
WITH info AS (
SELECT state,
        SUM(CASE WHEN stars = 5 THEN 1 ELSE 0 END) as n_businesses
FROM yelp_business
GROUP BY state
ORDER BY n_businesses DESC, state)
SELECT state, n_businesses
FROM (SELECT  *, 
            DENSE_RANK() OVER(ORDER BY n_businesses DESC) AS rnk
        FROM info) t
WHERE rnk < 5
ORDER BY n_businesses DESC, state

---------------------------------------------------------------------------------------- 

-- Reviews of Categories
--   https://platform.stratascratch.com/coding/10049-reviews-of-categories?python=
-- https://stackoverflow.com/questions/29419993/split-column-into-multiple-rows-in-postgres

WITH category_info AS (SELECT 
        unnest(string_to_array(categories, ';')) AS category,
        review_count
    FROM yelp_business)
SELECT category, SUM(review_count) as review_cnt
FROM category_info
GROUP BY category
ORDER BY review_cnt DESC

---------------------------------------------------------------------------------------- 

-- Number of violations
-- https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations?python=

SELECT to_char(inspection_date, 'YYYY') as year,
    COUNT(*)
FROM sf_restaurant_health_violations
WHERE business_name = 'Roxanne Cafe'
AND violation_id IS NOT NULL
GROUP BY year


---------------------------------------------------------------------------------------- 
--Classify Business Type
--https://platform.stratascratch.com/coding/9726-classify-business-type?python=

SELECT DISTINCT business_name,
        CASE WHEN business_name ILIKE '%School%' then 'school'
            WHEN business_name ILIKE '%Restaurant%' then 'restaurant'
            WHEN business_name ILIKE '%cafe%' 
                    OR  business_name ILIKE '%café%' 
                    OR business_name ILIKE '%coffee%' then 'cafe' 
            ELSE 'other' 
            END AS business_type
FROM sf_restaurant_health_violations

---------------------------------------------------------------------------------------- 
-- Host Popularity Rental Prices
-- https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?python=
WITH info AS (
SELECT price, room_type, host_since, zipcode, number_of_reviews,
    CASE WHEN number_of_reviews = 0 THEN 'New'
            WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
            WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
            WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
            ELSE 'Hot' END as popularity_rating
    
FROM airbnb_host_searches
GROUP BY price, room_type, host_since, zipcode, number_of_reviews)

SELECT popularity_rating,
        MIN(price) AS minimum_price,
        AVG(price) AS average_price,
        MAX(price) AS maximum_price 
FROM info
GROUP BY popularity_rating
