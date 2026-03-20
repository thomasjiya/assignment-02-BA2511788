-- Q3.1
-- ============================================

CREATE DATABASE IF NOT EXISTS retail_dw;
USE retail_dw;

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ============================================
-- DIMENSION TABLE 1: dim_date -- Stores all date-related attributes
-- ============================================
CREATE TABLE dim_date (
    date_id       INT          NOT NULL,
    full_date     DATE         NOT NULL,
    day           INT          NOT NULL,
    month         INT          NOT NULL,
    month_name    VARCHAR(20)  NOT NULL,
    quarter       INT          NOT NULL,
    year          INT          NOT NULL,
    day_of_week   VARCHAR(20)  NOT NULL,
    is_weekend    BOOLEAN      NOT NULL,
    CONSTRAINT pk_dim_date PRIMARY KEY (date_id)
);

-- ============================================
-- DIMENSION TABLE 2: dim_store -- Stores all store-related attributes
-- ============================================
CREATE TABLE dim_store (
    store_id      INT          NOT NULL AUTO_INCREMENT,
    store_name    VARCHAR(100) NOT NULL,
    store_city    VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_dim_store PRIMARY KEY (store_id)
);

-- ============================================
-- DIMENSION TABLE 3: dim_product -- Stores all product-related attributes
-- ============================================
CREATE TABLE dim_product (
    product_id    INT          NOT NULL AUTO_INCREMENT,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_dim_product PRIMARY KEY (product_id)
);

-- ============================================
-- FACT TABLE: fact_sales
-- Central table storing all numeric measures
-- Links to all 3 dimension tables via foreign keys
-- ============================================
CREATE TABLE fact_sales (
    sale_id          INT           NOT NULL AUTO_INCREMENT,
    transaction_id   VARCHAR(10)   NOT NULL,
    date_id          INT           NOT NULL,
    store_id         INT           NOT NULL,
    product_id       INT           NOT NULL,
    customer_id      VARCHAR(10)   NOT NULL,
    units_sold       INT           NOT NULL,
    unit_price       DECIMAL(10,2) NOT NULL,
    total_revenue    DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_fact_sales   PRIMARY KEY (sale_id),
    CONSTRAINT fk_date         FOREIGN KEY (date_id)    REFERENCES dim_date(date_id),
    CONSTRAINT fk_store        FOREIGN KEY (store_id)   REFERENCES dim_store(store_id),
    CONSTRAINT fk_product      FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ============================================
-- INSERT: dim_date -- Cleaned: all dates standardized to YYYY-MM-DD
-- ============================================
INSERT INTO dim_date VALUES
(20230829, '2023-08-29', 29, 8,  'August',    3, 2023, 'Tuesday',   FALSE),
(20231212, '2023-12-12', 12, 12, 'December',  4, 2023, 'Tuesday',   FALSE),
(20230205, '2023-02-05', 5,  2,  'February',  1, 2023, 'Sunday',    TRUE),
(20230220, '2023-02-20', 20, 2,  'February',  1, 2023, 'Monday',    FALSE),
(20230115, '2023-01-15', 15, 1,  'January',   1, 2023, 'Sunday',    TRUE),
(20230809, '2023-08-09', 9,  8,  'August',    3, 2023, 'Wednesday', FALSE),
(20230331, '2023-03-31', 31, 3,  'March',     1, 2023, 'Friday',    FALSE),
(20231026, '2023-10-26', 26, 10, 'October',   4, 2023, 'Thursday',  FALSE),
(20231208, '2023-12-08', 8,  12, 'December',  4, 2023, 'Friday',    FALSE),
(20230815, '2023-08-15', 15, 8,  'August',    3, 2023, 'Tuesday',   FALSE);

-- ============================================
-- INSERT: dim_store -- Cleaned: NULL store_city values fixed
-- ============================================
INSERT INTO dim_store (store_name, store_city) VALUES
('Chennai Anna',    'Chennai'),
('Delhi South',     'Delhi'),
('Bangalore MG',    'Bangalore'),
('Pune FC Road',    'Pune'),
('Mumbai Central',  'Mumbai');

-- ============================================
-- INSERT: dim_product -- Cleaned: category casing standardized
-- 'electronics' → 'Electronics'
-- 'Grocery'     → 'Groceries'
-- ============================================
INSERT INTO dim_product (product_name, category, unit_price) VALUES
('Speaker',     'Electronics', 49262.78),
('Tablet',      'Electronics', 23226.12),
('Phone',       'Electronics', 48703.39),
('Smartwatch',  'Electronics', 58851.01),
('Atta 10kg',   'Groceries',   52464.00),
('Jeans',       'Clothing',     2317.47),
('Biscuits',    'Groceries',   27469.99),
('Laptop',      'Electronics', 42343.15),
('Jacket',      'Clothing',    30187.24),
('Saree',       'Clothing',    35451.81);

-- ============================================
-- INSERT: fact_sales
-- 10 cleaned rows.
-- total_revenue = units_sold * unit_price
-- ============================================
INSERT INTO fact_sales 
(transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price, total_revenue) 
VALUES
('TXN5000', 20230829, 1, 1,  'CUST045', 3,  49262.78, 147788.34),
('TXN5001', 20231212, 1, 2,  'CUST021', 11, 23226.12, 255487.32),
('TXN5002', 20230205, 1, 3,  'CUST019', 20, 48703.39, 974067.80),
('TXN5003', 20230220, 2, 2,  'CUST007', 14, 23226.12, 325165.68),
('TXN5004', 20230115, 1, 4,  'CUST004', 10, 58851.01, 588510.10),
('TXN5005', 20230809, 3, 5,  'CUST027', 12, 52464.00, 629568.00),
('TXN5006', 20230331, 4, 4,  'CUST025', 6,  58851.01, 353106.06),
('TXN5007', 20231026, 4, 6,  'CUST041', 16,  2317.47,  37079.52),
('TXN5008', 20231208, 3, 7,  'CUST030', 9,  27469.99, 247229.91),
('TXN5009', 20230815, 3, 4,  'CUST020', 3,  58851.01, 176553.03);

SELECT * FROM dim_date;
SELECT * FROM dim_store;
SELECT * FROM dim_product;
SELECT * FROM fact_sales;