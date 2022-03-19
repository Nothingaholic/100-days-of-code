-- Friendly Movies Streamed Last Month
-- https://leetcode.com/problems/friendly-movies-streamed-last-month/

SELECT DISTINCT title
FROM tvprogram t, content c
WHERE t.content_id = c.content_id
AND program_date BETWEEN '2020-06-01' AND '2020-06-30'
AND kids_content = 'Y'
AND content_type = 'Movies'
----------------------------------------------------------------------------------------
-- Customer Order Frequency
-- https://leetcode.com/problems/customer-order-frequency/
-- 90.84%

SELECT c.customer_id, name
FROM customers c, product p, orders o
WHERE c.customer_id = o.customer_id
AND p.product_id = o.product_id
GROUP BY customer_id
HAVING SUM(CASE WHEN order_date BETWEEN '2020-06-01' AND '2020-06-30' THEN quantity ELSE 0 END * p.price) >=100
    AND SUM(CASE WHEN order_date BETWEEN '2020-07-01' AND '2020-07-31' THEN quantity ELSE 0 END * p.price) >=100


----------------------------------------------------------------------------------------
-- Find Users With Valid E-Mails
-- https://leetcode.com/problems/find-users-with-valid-e-mails/
-- 81.68%
SELECT * FROM users
WHERE mail RLIKE '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode.com'
AND mail LIKE '%@leetcode.com' -- edge case when @leetcode?com



# LIKE fix patterns, RLIKE for more flexible pattern
 
# prefix begins with a letter (lower or upper), then the head of string: '^[a-zA-Z]'
    # ^ means the beginning of the string
    # [] means character set. [A-Z] means any upper case chars
    # - means range
    
    
# what between domain and prefix are 0 or more letters (lower or upper), digit, underscore, period, dash: [a-zA-Z0-9_.-]*
    # notation: + or *
    #    + means at least one of the character from the preceding charset, and * means 0 or more
    # \ inside the charset mean skipping. \. means we want the dot as 
    #    for example: if we would like to find - itself as a character? use \-. 

# domain is '@leetcode.com'
    # @ refers to exact match
----------------------------------------------------------------------------------------
-- Wearhouse managers
-- https://leetcode.com/problems/warehouse-manager/

-- 64.38%
-- get volumn for each product_id
SELECT product_id,
        width * length * height as v
FROM products p
GROUP BY p.product_id


-- join warehouse with CTE
WITH volume AS(
                SELECT product_id,
                width * length * height as product_volume
                FROM products p
                GROUP BY p.product_id)
SELECT name as warehouse_name, SUM(units * product_volume) as volume
FROM warehouse w, volume v
WHERE w.product_id = v.product_id
GROUP BY name

-- faster 94.26% 
-- dont need temp table
SELECT name as warehouse_name,
        SUM(width * length * height* units) as volume
FROM products p, warehouse w
WHERE w.product_id = p.product_id
GROUP BY name
----------------------------------------------------------------------------------------
-- All Valid Triplets That Can Represent a Country
-- https://leetcode.com/problems/all-valid-triplets-that-can-represent-a-country/

SELECT a.student_name as member_A,
        b.student_name as member_B,
        c.student_name as member_C
FROM schoolA a, schoolB b, schoolC c
WHERE a.student_name != b.student_name
AND b.student_name != c.student_name
AND a.student_name != c.student_name

AND a.student_id != b.student_id
AND b.student_id != c.student_id
AND a.student_id != c.student_id
