/* 
9. In this database, there are some customers who have not made any orders. 
Among the customers who have made orders, find those who have never bought a product priced more than $70.
The results should be a list of customer names.
*/
SELECT c.customername, od.priceeach, o.shippeddate
FROM customers c, orders o, orderdetails od
WHERE c.customernumber = o.customernumber
AND o.ordernumber = od.ordernumber
AND od.priceeach <= 70;
/*
10. Find the number of sales made by each employee, 
including those who have not made any sales (e.g. the managers, the president, etc.). 
The results of your query should be of the form (employee ID, count of sales made). 
Employees who have never made a sale should have an associated count of zero.
*/