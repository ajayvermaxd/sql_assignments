-- Online Retail Store


-- You are working with a database for an online retail store. Here's an overview of the database schema:


----------------------------------------------------------------------------------------------------------
-- - Customers table:

-- - `customer_id` (Primary Key)

-- - `first_name'

-- - `last_name`

-- - `email`
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

-- Insert records into `Customers` table:

INSERT INTO Customers (customer_id, first_name, last_name, email)
VALUES
(1, 'Ajay', 'Kumar', 'ajay@gmail.com'),
(2, 'Simran', 'Salva', 'salva@gmail.com'),
(3, 'Durgesh', 'Pondichery', 'pondicherry@gmail.com'),
(4, 'Drupad', 'Gandepalli', 'gandepally@gmail.com'),
(5, 'Gowtham', 'Naidu', 'Naidu@gmail.com');

----------------------------------------------------------------------------------------------------------

-- - Orders table:

-- - `order_id` (Primary Key)

-- - `customer_id` (Foreign Key)

-- - `order_date`

-- - `total_amount`
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);


-- Insert records into `Orders` table:

INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2023-10-06', 500.10),
(2, 2, '2023-10-05', 350.20),
(3, 3, '2023-10-04', 650.00),
(4, 1, '2023-10-03', 120.00),
(5, 5, '2023-10-02', 300.00);

----------------------------------------------------------------------------------------------------------

-- - Products table:

-- - `product_id` (Primary Key)

-- - `product_name`

-- - `category_id` (Foreign Key)

-- - `price`
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT REFERENCES Categories(category_id),
    price DECIMAL(10, 2)
);

-- Insert records into `Products` table:

INSERT INTO Products (product_id, product_name, category_id, price)
VALUES
(1, 'Fan', 3, 700.99),
(2, 'Shirt', 2, 900.00),
(3, 'Running_Shoes', 5, 2000.00),
(4, 'Laptop', 1, 50000.00),
(5, 'Burger', 4, 200.00);

----------------------------------------------------------------------------------------------------------

-- - Categories table:

-- - `category_id` (Primary Key)

-- - `category_name`
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

-- Insert records into `Categories` table:

INSERT INTO Categories (category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home Appliances'),
(4, 'Food'),
(5, 'Sports');

----------------------------------------------------------------------------------------------------------

-- Create `OrderDetails` table:

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert records into `OrderDetails` table:

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 3),
(1, 2, 2),
(2, 3, 1),
(3, 4, 4),
(4, 1, 1),
(4, 3, 2),
(4, 5, 3),
(5, 2, 1),
(5, 4, 1),
(5, 6, 1);

----------------------------------------------------------------------------------------------------------


-- Create `ProductPriceHistory` table:

CREATE TABLE ProductPriceHistory (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    price DECIMAL(10, 2),
    date_recorded DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Insert records into `ProductPriceHistory` table:

-- Inserting historical prices for fan with product_id = 1
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (1, 800.00, '2023-01-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (1, 750.99, '2023-02-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (1, 680.00, '2023-07-15');

-- Inserting historical prices for shirt with product_id = 2
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (2, 980.00, '2023-01-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (2, 950.00, '2023-02-01');

-- Inserting historical prices for Running Shoes with product_id = 3
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (3, 1585.00, '2023-01-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (3, 1900.00, '2023-02-01');

-- Inserting historical prices for Laptop with product_id = 4
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (4, 45000.00, '2023-01-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (4, 40000.00, '2023-02-01');

-- Inserting historical prices for Burger with product_id = 5
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (5, 300.00, '2023-01-01');
INSERT INTO ProductPriceHistory (product_id, price, date_recorded) VALUES (5, 250.00, '2023-02-01');


----------------------------------------------------------------------------------------------------------

-- Instructions:

-- In this assignment, you will use SQL to retrieve and manipulate data from the database. The following queries involve complex scenarios:

-- Basic Queries:

-- 1. Retrieve a list of all customers along with their email addresses.
-- Query:-
SELECT first_name, last_name, email FROM Customers;

-- 2. Find the total number of orders placed by each customer.
-- Query:-
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 3. List all products along with their prices.
-- Query:-
SELECT product_id, product_name, price
FROM Products;

-- 4. Retrieve the category with the highest number of products.
-- Query:-
SELECT category_id, COUNT(product_id) AS product_count
FROM Products
GROUP BY category_id
ORDER BY product_count DESC
LIMIT 1;

-- Intermediate Queries:

-- 5. Find all customers who have not placed any orders.
-- Query:-
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 6. List the products with the highest and lowest prices.
-- Query:-
-- product with the highest price
SELECT product_id, product_name, price
FROM Products
WHERE price = (SELECT MAX(price) FROM Products)
UNION ALL
-- product with the lowest price
SELECT product_id, product_name, price
FROM Products
WHERE price = (SELECT MIN(price) FROM Products);

-- 7. Calculate the average order amount for each customer.
-- Query:-
SELECT o.customer_id, c.first_name, c.last_name, AVG(o.total_amount) AS avg_order_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.first_name, c.last_name;


-- 8. Find the categories that do not have any products.
-- Query:-
SELECT c.category_id, c.category_name
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
WHERE p.product_id IS NULL;

-- Advanced Queries:

-- 9. Retrieve a list of customers who have placed orders for products with a price higher than $100.
-- Query:-
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.email
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.order_id = p.product_id 
WHERE p.price > 100;

-- 10. List the customers who have placed orders for products from at least three different categories.
-- Query:-
WITH OrderCategories AS (
    SELECT o.customer_id, p.category_id
    FROM Orders o
    JOIN Products p ON o.order_id = p.product_id
)
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM Customers c
JOIN (
    SELECT customer_id
    FROM OrderCategories
    GROUP BY customer_id
    HAVING COUNT(DISTINCT category_id) >= 3
) sub_query ON c.customer_id = sub_query.customer_id;

-- 11. Find the products with the highest and lowest average customer ratings (if a rating table is available).


-- 12. Calculate the total revenue generated from each category.
-- Query:-
SELECT c.category_id, c.category_name, SUM(od.quantity * p.price) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
GROUP BY c.category_id, c.category_name;

-- Complex Queries:

-- 13. Retrieve the names of customers who have placed orders in the last 30 days.
-- Query:-
SELECT DISTINCT c.first_name, c.last_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- 14. List the products that have been out of stock for more than 7 days.
-- Query:-
SELECT product_id, product_name
FROM Products
WHERE out_of_stock_date <= CURDATE() - INTERVAL 7 DAY;

-- 15. Find the products that have the highest fluctuation in price (i.e., the products where the difference between the highest and lowest prices is the greatest).
-- Query:-
SELECT 
    p.product_id, 
    p.product_name,
    MAX(pph.price) - MIN(pph.price) AS price_fluctuation
FROM 
    ProductPriceHistory pph
JOIN 
    Products p ON pph.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name
ORDER BY 
    price_fluctuation DESC
LIMIT 1;

-- 16. Create a summary report showing the category names, the total number of products in each category, and the total revenue generated from products in each category.
-- Query:-
SELECT 
    c.category_name,
    COUNT(DISTINCT p.product_id) AS total_products,
    SUM(o.total_amount) AS total_revenue
FROM 
    Categories c
LEFT JOIN 
    Products p ON c.category_id = p.category_id
LEFT JOIN 
    Orders o ON p.product_id = (SELECT product_id FROM Orders WHERE customer_id = o.customer_id LIMIT 1)
GROUP BY 
    c.category_id, c.category_name
ORDER BY 
    total_revenue DESC;

-- Expert-Level Queries:

-- 17. Retrieve a list of customers who have placed orders for every product in a specific category.
-- Query:-
SELECT c.customer_id, c.first_name, c.last_name
FROM Customers c
WHERE NOT EXISTS (
    SELECT p.product_id
    FROM Products p
    WHERE p.category_id = 1
    AND NOT EXISTS (
        SELECT o.order_id
        FROM Orders o
        JOIN OrderDetails od ON o.order_id = od.order_id
        WHERE od.product_id = p.product_id AND o.customer_id = c.customer_id
    )
);

-- 18. Calculate the average order amount for each month over the past year.
-- Query:-
SELECT 
    MONTH(order_date) AS month,
    YEAR(order_date) AS year,
    AVG(total_amount) AS average_order_amount
FROM Orders
WHERE order_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY MONTH(order_date), YEAR(order_date)
ORDER BY year, month;

-- 19. Find the customers who have placed orders with a total amount that is significantly higher than their average order amount.
-- Query:-
SELECT o.customer_id, c.first_name, c.last_name, o.order_id, o.total_amount, avg_orders.avg_amount
FROM Orders AS o
JOIN Customers AS c ON o.customer_id = c.customer_id
JOIN (
    SELECT customer_id, AVG(total_amount) AS avg_amount
    FROM Orders
    GROUP BY customer_id
) AS avg_orders ON o.customer_id = avg_orders.customer_id
WHERE o.total_amount > avg_orders.avg_amount * 1.5 -- 1.5 times the average as a threshold
ORDER BY o.customer_id, o.total_amount DESC;

-- 20. Create a report that displays the top 5 best-selling products in each category.
-- Query:-
SELECT c.category_name, p.product_name, SUM(od.quantity) AS total_sales
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN OrderDetails od ON p.product_id = od.product_id
JOIN Orders o ON od.order_id = o.order_id
GROUP BY c.category_id, p.product_id
HAVING total_sales = (
  SELECT MAX(S.total_sales)
  FROM (
    SELECT SUM(od2.quantity) AS total_sales
    FROM Products p2
    JOIN OrderDetails od2 ON p2.product_id = od2.product_id
    JOIN Orders o2 ON od2.order_id = o2.order_id
    WHERE p2.category_id = c.category_id
    GROUP BY p2.product_id
  ) S
)
ORDER BY c.category_id;