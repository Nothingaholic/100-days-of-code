
-- Not Boring Movies
-- https://leetcode.com/problems/not-boring-movies/

SELECT *
   FROM cinema
   WHERE id % 2 = 1 -- to get odd id
AND description != 'boring'
ORDER BY rating DESC

----------------------------------------------------------------------------------------
-- Actors and Directors Who Cooperated At Least Three Times
-- https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/submissions/
SELECT actor_id, director_id
FROM actordirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3
----------------------------------------------------------------------------------------
-- Product Sales Analysis I
-- https://leetcode.com/problems/product-sales-analysis-i/

SELECT p.product_name, s.year, s.price
FROM sales s, product p
WHERE s.product_id = p.product_id
----------------------------------------------------------------------------------------
-- Product Sales Analysis II
-- https://leetcode.com/problems/product-sales-analysis-ii/

SELECT p.product_id, sum(quantity) as total_quantity
FROM sales s, product p
WHERE s.product_id = p.product_id
GROUP BY p.product_id
----------------------------------------------------------------------------------------
-- Product Sales Analysis III
-- https://leetcode.com/problems/product-sales-analysis-iii/

-- incorrect
-- only get min(year), match  product that has min(year)
-- but may not the first year
SELECT s.product_id, 
        s.year as first_year, 
        s.quantity, s.price 
FROM sales s
     WHERE year IN (SELECT MIN(year)
           FROM sales s1 GROUP BY s1.product_id); 


-- correct
SELECT s.product_id, 
        s.year as first_year, 
        s.quantity, s.price 
FROM sales s
     WHERE (s.product_id, s.year)  IN (SELECT product_id, MIN(year)
           FROM sales s1 GROUP BY s1.product_id); 