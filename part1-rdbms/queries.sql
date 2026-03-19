-- Q1.3

USE orders_db;

-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    customer_id,
    customer_name,
    customer_city,
    SUM(unit_price * quantity) AS total_order_value
FROM orders_flat
WHERE customer_city = 'Mumbai'
GROUP BY customer_id, customer_name, customer_city;

-- Q2: Find the top 3 products by total quantity sold
SELECT 
    product_id,
    product_name,
    category,
    SUM(quantity) AS total_quantity_sold
FROM orders_flat
GROUP BY product_id, product_name, category
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    sales_rep_id,
    sales_rep_name,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_flat
GROUP BY sales_rep_id, sales_rep_name
ORDER BY unique_customers DESC;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    order_id,
    customer_name,
    product_name,
    quantity,
    unit_price,
    (unit_price * quantity) AS total_value
FROM orders_flat
WHERE (unit_price * quantity) > 10000
ORDER BY total_value DESC;

-- Q5: Identify any products that have never been ordered
SELECT DISTINCT
    product_id,
    product_name,
    category,
    unit_price
FROM orders_flat
WHERE product_id NOT IN (
    SELECT DISTINCT product_id 
    FROM orders_flat 
    WHERE order_id IS NOT NULL
);