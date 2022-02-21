/*
7. For each customer, find the number of products from each product line that they have purchased.
The results of your tuple should be of the form (customer name, product line name, 
number of products from this product line).

You don't need to include the query results for this one. Your answer should just be the query itself.
Hint: the results are for each customer and for each product line,
 meaning you will need a GROUP BY clause that groups by two columns.
*/

SELECT c.customername, 
		pl.productline, 
		COUNT(*) as "numberofproducts"
FROM customers c, orders o,
	orderdetails od, products p, productlines pl
WHERE c.customernumber = o.customernumber 
		AND o.ordernumber = od.ordernumber
		AND od.productcode = p.productcode
		AND p.productline = pl.productline
GROUP BY c.customername, pl.productline;

/*
8. Find all instances where the same customer placed different orders exactly 7 days apart. 
The results of your query should be of the form (customer name, order number 1, order date 1, 
order number 2, order date 2).

Hint: In order to get the difference between two dates, you can subtract them, i.e., 
for date columns d1 and d2, the number of days between the two dates is d1 - d2.
*/

SELECT c.customernumber, o1.ordernumber AS "ordernumber1",
		o1.orderdate AS "orderdate1",
		o2.ordernumber AS "ordernumber2",
		o2.orderdate AS "orderdate2"
		FROM customers c, orders o1, orders o2
WHERE c.customernumber= o1.customernumber
AND o1.customernumber = o2.customernumber
AND date(o2.orderdate) - date(o1.orderdate) = 7;
