-- Stratascratch
-- Amazon Interview Questions


/* Order Details
Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.

Tables: customers, orders

customers
id                  int
first_name          varchar
last_name           varchar
city                varchar
address             varchar
phone_number        varchar

orders
id                  int
cust_id             int
order_date          datetime
order_details       varchar
total_order_cost    int

*/

select c.first_name, o.order_date, o.order_details,
sum(o.total_order_cost)
from customers c
join orders o on o.cust_id = c.id
where  c.first_name = 'Jill' or c.first_name = 'Eva'
group by c.first_name, o.order_date, o.order_details,
o.total_order_cost, o.cust_id
order by o.cust_id;

