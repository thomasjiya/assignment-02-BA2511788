-- Q1.2
CREATE DATABASE orders_db;
USE orders_db;
-- TABLE 1: Customers
CREATE TABLE Customers (
    customer_id   VARCHAR(10)  NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city  VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (customer_id)
);
-- TABLE 2: Products
CREATE TABLE Products (
    product_id   VARCHAR(10)  NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);
-- TABLE 3: SalesReps
CREATE TABLE SalesReps (
    sales_rep_id   VARCHAR(10)  NOT NULL,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address  VARCHAR(200) NOT NULL,
    CONSTRAINT pk_salesreps PRIMARY KEY (sales_rep_id)
);
-- TABLE 4: Orders
CREATE TABLE Orders (
    order_id     VARCHAR(10)  NOT NULL,
    customer_id  VARCHAR(10)  NOT NULL,
    product_id   VARCHAR(10)  NOT NULL,
    sales_rep_id VARCHAR(10)  NOT NULL,
    quantity     INT          NOT NULL,
    order_date   DATE         NOT NULL,
    CONSTRAINT pk_orders     PRIMARY KEY (order_id),
    CONSTRAINT fk_customer   FOREIGN KEY (customer_id)  REFERENCES Customers(customer_id),
    CONSTRAINT fk_product    FOREIGN KEY (product_id)   REFERENCES Products(product_id),
    CONSTRAINT fk_salesrep   FOREIGN KEY (sales_rep_id) REFERENCES SalesReps(sales_rep_id)
);
-- Customers
INSERT INTO Customers VALUES ('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai');
INSERT INTO Customers VALUES ('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi');
INSERT INTO Customers VALUES ('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore');
INSERT INTO Customers VALUES ('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai');
INSERT INTO Customers VALUES ('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');

-- Products
INSERT INTO Products VALUES ('P001', 'Laptop',        'Electronics', 55000.00);
INSERT INTO Products VALUES ('P002', 'Mouse',         'Electronics',   800.00);
INSERT INTO Products VALUES ('P003', 'Desk Chair',    'Furniture',    8500.00);
INSERT INTO Products VALUES ('P004', 'Notebook',      'Stationery',    120.00);
INSERT INTO Products VALUES ('P005', 'Headphones',    'Electronics',  3200.00);

-- SalesReps 
INSERT INTO SalesReps VALUES ('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021');
INSERT INTO SalesReps VALUES ('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001');
INSERT INTO SalesReps VALUES ('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');

-- Orders 
INSERT INTO Orders VALUES ('ORD1000', 'C002', 'P001', 'SR03', 2, '2023-05-21');
INSERT INTO Orders VALUES ('ORD1001', 'C004', 'P002', 'SR03', 5, '2023-02-22');
INSERT INTO Orders VALUES ('ORD1002', 'C002', 'P005', 'SR02', 1, '2023-01-17');
INSERT INTO Orders VALUES ('ORD1003', 'C002', 'P002', 'SR01', 5, '2023-09-16');
INSERT INTO Orders VALUES ('ORD1004', 'C001', 'P005', 'SR01', 5, '2023-11-29');