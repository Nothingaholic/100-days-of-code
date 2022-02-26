/*
List the total payments earned by each salesperson. 
Show the employee's name and the number of payments earned by them.

Hint: relate each employee to their customers, 
and sum over all of the payments that those customers have made.
*/
SELECT firstname, lastname, sum(amount)
FROM employees e, customers c, payments p
WHERE e.employeenumber = c.salesrepemployeenumber
AND c.customernumber = p.customernumber
GROUP BY employeeNumber,firstname, lastname;

/*
Without using joins, find all customers who have shipped orders with a total order cost greater than $60,000.

Hint: this will require both a subquery and a group.

Start with a subquery that finds all orders that are worth more than $60,000:
Group together all order details by their order number.
Multiply the quantity times the item price for every order detail, 
and sum over all of the order details for a given order number.

The result of the subquery should be a list of all of the order numbers 
that have a total order cost of greater than $60,000. 
You can then use this subquery result to find all customers who correspond to those orders.
*/
SELECT customernumber
FROM orders
WHERE status = 'Shipped'
AND ordernumber in (SELECT ordernumber
					FROM orderdetails
					GROUP BY orderNumber
					HAVING SUM(priceEach*quantityOrdered) > 60000);