-- ============================================
-- Q5.1
-- ============================================

-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
    c.name            AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM read_csv_auto('../datasets/customers.csv') AS c
LEFT JOIN read_json_auto('../datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_orders DESC;


-- Q2: Find the top 3 customers by total order value
SELECT
    c.customer_id,
    c.name              AS customer_name,
    c.city,
    SUM(o.total_amount) AS total_order_value,
    COUNT(o.order_id)   AS total_orders
FROM read_csv_auto('../datasets/customers.csv') AS c
JOIN read_json_auto('../datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_order_value DESC
LIMIT 3;


-- Q3: List all orders placed by customers from Bangalore
SELECT
    c.customer_id,
    c.name            AS customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.num_items
FROM read_csv_auto('../datasets/customers.csv') AS c
JOIN read_json_auto('../datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
WHERE c.city = 'Bangalore'
ORDER BY o.order_date;


-- Q4: Join all three files to show customer name, order date, product name, and quantity
SELECT
    c.name          AS customer_name,
    o.order_date,
    o.order_id,
    o.status,
    o.num_items     AS quantity,
    o.total_amount
FROM read_csv_auto('../datasets/customers.csv') AS c
JOIN read_json_auto('../datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date, c.name;