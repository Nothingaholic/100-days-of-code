/*
1. Find the email addresses for employees Tom King and Barry Jones. 
The resulting tuples should be of the form (full name, email address).
You should use their names in the query itself, i.e., 
don't find out what their IDs are and use the IDs in the query.
*/
SELECT (firstname || ' '|| lastname) as "employeename",
		email
FROM employees
WHERE firstname in ('Tom', 'Barry')
	AND lastname in ('King', 'Jones');

/*2. Find all orders from April, 2003. 
The resulting tuples should be of the form (order number, order date, status). 
Sort the tuples from most recent to least recent.
*/

SELECT ordernumber,
		orderdate,
		status
FROM orders
WHERE shippeddate ::text LIKE '2004-04%';