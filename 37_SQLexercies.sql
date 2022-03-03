/*
5. Find the car product(s) in the database with the lowest MSRP.
 All car products in the database have a product line that is either Classic Cars or Vintage Cars. 
 The result(s) of your query should be of the form (product name, product line, MSRP).
*/
SELECT productname,
		productline,
		msrp
FROM products
WHERE productline in ('Classic Cars', 'Vintage Cars')
AND msrp = (SELECT min(MSRP)
		   FROM products 
		   WHERE productline in ('Classic Cars', 'Vintage Cars'))
group by productname, productline, msrp;

/*
6. Find all employees in the database who have made at least 25 sales 
(i.e. have been the salesperson for at least 25 customer orders). 
The results of your query should be of the form (employee first name, 
employee last name, number of sales). Name the number of sales column numSales. 
*/

SELECT e.firstname AS "employeefirstname",
		e.lastname AS "employeelastname",
		COUNT(o.ordernumber) AS "numSales"
FROM employees e, customers c, orders o
WHERE e.employeenumber = c.salesrepemployeenumber
	AND o.customernumber = c.customernumber
GROUP BY e.firstname, e.lastname
HAVING COUNT(*) >= 25;
