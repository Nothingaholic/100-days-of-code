/*
9. In this database, there are some customers who have not made any orders. 
Among the customers who have made orders, find those who have never bought a product priced more than $70.
The results should be a list of customer names.
*/
SELECT customername
FROM customers c
RIGHT JOIN orders o ON c.customernumber = o.customernumber -- customers who made orders
WHERE o.customernumber not in ( SELECT c.customernumber
							 FROM customers c, orders o, orderdetails od, products p
							 WHERE c.customernumber = o.customernumber
							 AND o.ordernumber = od.ordernumber
							AND od.productcode = p.productcode
							AND buyprice NOT IN (SELECT buyprice
												 FROM products
												 WHERE buyprice >= 70
												 )
							);
							
							
/*
10. Find the number of sales made by each employee, 
including those who have not made any sales (e.g. the managers, the president, etc.). 
The results of your query should be of the form (employee ID, count of sales made). 
Employees who have never made a sale should have an associated count of zero.
*/
SELECT e.employeenumber, COUNT(o.customernumber) as " count of sales made"
FROM employees e
LEFT JOIN customers c ON c.salesrepemployeenumber = e.employeenumber
LEFT JOIN orders o ON o.customernumber = c.customernumber
GROUP BY employeenumber;

