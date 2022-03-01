/*
Find the number of customers that each employee represents. 
The results of your query should be (employee number, number of customers that the employee represents).
*/
SELECT employeenumber, count(*)
FROM employees e, customers c
WHERE c.salesrepemployeenumber = e.employeenumber
GROUP BY employeenumber;

-- customer who have employee represent
SELECT salesRepEmployeeNumber, COUNT(*)
FROM customers
GROUP BY salesRepEmployeeNumber;

-- use left join, we can show all employee, including who present a customer
SELECT employeenumber, count(*)
FROM employees e
LEFT JOIN customers c
ON c.salesrepemployeenumber = e.employeenumber
GROUP BY employeenumber;


/*
How many payments have been made by each customer? 
Show the customer name and the number of payments that customer has made.

Hint: GROUP BY both the customer number and customer name, 
so that you can display the customer's name in the results.
*/
SELECT customername, count(*)
FROM customers c, payments p
WHERE c.customernumber = p.customernumber
GROUP BY c.customernumber, customername;