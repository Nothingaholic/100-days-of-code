-- Stratascratch
-- Amazon, mid

/* 
Highest Cost Orders
Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output their first name, total cost of their items, and the date.
 
 For simplicity, you can assume that every first name in the dataset is unique.
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

-- For each customer, find the total_order_cost between day X and day Y,
-- if they make >=1 order in a day, sum the total order cost
SELECT cust_id, order_date, sum(total_order_cost) as total_order_cost
            FROM orders
            WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01'
            GROUP BY cust_id, order_date;

-- want the highest daily total cost
SELECT ( max(total_order_cost)
FROM 
    (SELECT cust_id, order_date, sum(total_order_cost) as total_order_cost
            FROM orders
            WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01'
            GROUP BY cust_id, order_date) b);

-- to output customer name and total cost, order data, we need to
-- left join with customers table (we only wants customer who makes orders)
SELECT first_name, 
        order_date, sum(total_order_cost)
        FROM orders o

LEFT JOIN customers c ON c.id = o.cust_id
WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01' -- if we don't have this condition, 
            -- we may have customers who can have sum(total_order_cost) on different day
            -- with same sum(total_order_cost) between day X and Y
GROUP BY first_name, order_date
HAVING sum(total_order_cost)  = 
(SELECT  max(total_order_cost)
FROM 
    (SELECT cust_id, order_date, sum(total_order_cost) as total_order_cost
            FROM orders
            WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01' --If we took out the condition in the inner query,
                                --  we just get the sum(total_order_cost) for all customers, 
            -- then we are matching the this against any customer with sum(total_order_cost).
            GROUP BY cust_id, order_date) b);