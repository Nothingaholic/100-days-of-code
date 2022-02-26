/* 
Find all employees who report to Anthony Bow. 
List the employees’ full names.

Hint: join employees with itself.
*/
SELECT e1.firstname, e1.lastname
FROM employees e1, employees e2
-- one employee is report to another one
WHERE e1.reportsTo = e2.employeenumber
ANd e2.firstname = 'Anthony'
AND e2.lastname = 'Bow';

/*

Find all payments greater than $100,000 along with the associated customers who made the payments.
Sort them with the highest payment at the top. Display paymentDate, amount, customerName. 
Use the payments table.
*/
SELECT paymentdate, 
			amount, 
			c.customername
from customers c, payments p
WHERE c.customernumber = p.customernumber
AND amount > 100000
ORDER BY amount DESC;