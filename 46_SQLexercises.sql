/* 
List all products ordered by customer Herkku Gifts, sorted by order date. 
Display productName, quantityOrdered, priceEach, orderDate.

Hint: this is another example where you need to figure out how to connect customers 
to products that they have ordered.

*/
SELECT productname, quantityordered, priceeach, orderdate
FROM customers c, orders o, orderdetails od, products p
WHERE c.customernumber = o.customernumber
AND o.ordernumber = od.ordernumber
AND od.productcode = p.productcode
AND customername = 'Herkku Gifts'
ORDER BY orderdate;

/*
Without using a join, get a distinct list of employees who represent customers.

Hint: get a list of all sales employee numbers from the customers table in a subquery,
and then use an outer query to get the names of those employees.

*/
SELECT firstname, lastname
FROM employees e
WHERE e.employeenumber in (SELECT salesrepemployeenumber
			FROM customers);