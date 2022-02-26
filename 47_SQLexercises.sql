/*
Find the customer who made the highest payment and report their customer ID.
*/
SELECT customernumber
FROM payments
WHERE amount = (SELECT max(amount)
			   FROM payments);
/*
Find the customer who made the highest payment, but this time project all payment fields, 
and order payments by amount from highest to lowest.

Hint: use the last problem's solution in another subquery.
*/
-- For this query, we want to print the customer who made the highest payment which is #141
-- but we want to print out all the payment that customer 141 made.
SELECT *
FROM payments
WHERE customernumber = (SELECT customernumber
							FROM payments
							WHERE amount = (SELECT max(amount)
										   FROM payments)
						);

-- or 
SELECT *
	FROM payments p, (SELECT customerNumber
                  FROM payments p
	                  WHERE amount = (SELECT MAX(amount)
	                                  FROM payments)) AS cust
	WHERE p.customerNumber = cust.customerNumber
ORDER BY amount DESC;
