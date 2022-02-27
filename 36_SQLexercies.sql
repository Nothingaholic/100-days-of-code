/*
3. Find all orders by customer Mini Classics. 
The resulting tuples should be of the form (order number, order date).
*/

SELECT ordernumber, orderdate
FROM customers c, orders o
where c.customernumber = o.customernumber 
AND customername = 'Mini Classics';


/*
4. Find the number of products in the database that have been bought by at least one foreign customer. 
Foreign customers have a non-null country field whose value is not 'USA'.
 The result of your query should be a single number.
 */
 
SELECT COUNT(*) as "number of product"
FROM customers c, orders o
WHERE c.customernumber = o.customernumber
	AND c.customernumber not in (SELECT customernumber 
									FROM customers
									WHERE country = 'USA')
