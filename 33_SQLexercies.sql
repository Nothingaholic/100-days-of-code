/* 
Select all customers that are from NYC, Paris, London, Madrid, or Boston.
	Hint: use the IN operator along with a list of city names.
*/
SELECT * 
FROM customers
WHERE city IN ('NYC', 'Paris', 'London', 'Madrid', 'Boston');

/* Find all orders that shipped in December 2004. 
Note: to do string pattern matching against a date column d1, 
you can do d1::text LIKE 'yyyy-mm-dd' in the WHERE clause. 
The ::text is a type cast that tells SQL to treat the date value as a string.
*/ 
SELECT ordernumber, shippeddate
FROM orders
WHERE shippeddate ::text LIKE '2004%';

-- or 
SELECT ordernumber, shippeddate
FROM orders
WHERE shippeddate >= '2004-01-01' 
	AND shippeddate <= '2004-12-31';
	
-- Find the list of all unique customer cities. 
SELECT DISTINCT city
FROM customers;
	
-- Find the number, order date, & status of all orders not shipped
SELECT ordernumber, orderdate, status
FROM orders
WHERE status != 'Shipped';

/* Find the productCode and total price (quantity times price each) 
of each item in the order details table sorted with highest total price at the top. */
SELECT ordernumber, 
		quantityordered * priceeach AS "total_price"
FROM orderdetails
ORDER BY total_price DESC;

-- Find all products by Classic Metal Creations and Gearbox Collectibles in the Classic Cars product line.
SELECT productname, productline, productvendor
FROM products
WHERE productline = 'Classic Cars'
	AND productvendor in ('Classic Metal Creations', 'Gearbox Collectibles');