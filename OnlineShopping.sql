-- CREATE TABLES

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    registration_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT REFERENCES Category(category_id) ON DELETE SET NULL
);

CREATE TABLE Supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Manager (
    manager_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(50) NOT NULL
);

CREATE TABLE "Order" (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customer(customer_id) ON DELETE CASCADE,
    order_date DATE DEFAULT CURRENT_DATE,
    shipping_address VARCHAR(255),
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending'
);

CREATE TABLE Order_Item (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES "Order"(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES Product(product_id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES "Order"(order_id) ON DELETE CASCADE,
    payment_date DATE DEFAULT CURRENT_DATE,
    payment_method VARCHAR(50) NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL
);

-- INSERT DATA INTO TABLES

-- Customers
INSERT INTO Customer (first_name, last_name, email, phone, address) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave'),
('Alice', 'Johnson', 'alice.j@example.com', '111-222-3333', '789 Pine Rd');

-- Categories
INSERT INTO Category (category_name, description) 
VALUES 
('Electronics', 'Electronic items including smartphones, laptops, and more'),
('Clothing', 'Various clothing items'),
('Home Appliances', 'Appliances for home use');

-- Products
INSERT INTO Product (product_name, description, price, stock_quantity, category_id) 
VALUES 
('Smartphone', 'High-end smartphone with 128GB storage', 699.99, 50, 1),
('Laptop', 'Powerful laptop with 16GB RAM and 512GB SSD', 1199.99, 30, 1),
('T-shirt', 'Cotton T-shirt in various colors', 19.99, 200, 2),
('Refrigerator', 'Energy-efficient refrigerator with freezer', 799.99, 15, 3),
('Headphones', 'Noise-cancelling wireless headphones', 199.99, 100, 1),
('Smartwatch', 'Fitness tracking smartwatch with heart rate monitor', 249.99, 150, 1),
('Jeans', 'Denim jeans with slim fit', 49.99, 300, 2),
('Blender', 'High-power kitchen blender', 89.99, 50, 3),
('Microwave', 'Compact microwave with digital controls', 129.99, 75, 3);

-- Suppliers
INSERT INTO Supplier (supplier_name, contact_name, phone, address) 
VALUES 
('Tech Supplies Inc.', 'Robert King', '555-123-4567', '321 Tech Blvd'),
('Fashion Ware Ltd.', 'Emily Clarke', '555-234-5678', '789 Fashion St'),
('Home Essentials Co.', 'Mike Adams', '555-345-6789', '456 Appliance Rd');

-- Managers
INSERT INTO Manager (first_name, last_name, email, phone, role) 
VALUES 
('Alice', 'Johnson', 'alice.j@example.com', '111-222-3333', 'Product Manager'),
('Bob', 'Smith', 'bob.s@example.com', '222-333-4444', 'Order Manager'),
('James', 'Miller', 'james.m@example.com', '333-444-5555', 'Sales Manager'),
('Sophia', 'Brown', 'sophia.b@example.com', '444-555-6666', 'Inventory Manager');

-- Orders
INSERT INTO "Order" (customer_id, order_date, shipping_address, total_amount, status) 
VALUES 
(1, CURRENT_DATE, '123 Main St', 719.98, 'shipped'),
(2, CURRENT_DATE, '456 Oak Ave', 249.99, 'pending');

-- Order Items
INSERT INTO Order_Item (order_id, product_id, quantity, price_at_purchase) 
VALUES 
(1, 1, 2, 699.99),  -- 2 Smartphones
(2, 5, 1, 199.99),  -- 1 Headphone
(1, 2, 1, 1199.99); -- 1 Laptop

-- Payments
INSERT INTO Payment (order_id, payment_date, payment_method, amount_paid) 
VALUES 
(1, CURRENT_DATE, 'Credit Card', 719.98),
(2, CURRENT_DATE, 'PayPal', 249.99);

-- 1. Retrieve all products with their category names
SELECT p.product_name, c.category_name, p.price
FROM Product p
JOIN Category c ON p.category_id = c.category_id;

-- 2. Retrieve all orders placed by a specific customer (Customer ID: 1)
SELECT o.order_id, o.order_date, o.total_amount, o.status
FROM "Order" o
WHERE o.customer_id = 1;

-- 3. Retrieve the details of all customers who have placed an order
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.email
FROM Customer c
JOIN "Order" o ON c.customer_id = o.customer_id;

-- 4. Find the product with the highest price
SELECT product_name, price
FROM Product
ORDER BY price DESC
LIMIT 1;

-- 5. Find the product with the lowest price
SELECT product_name, price
FROM Product
ORDER BY price ASC
LIMIT 1;

-- 6. Get the total number of products in each category
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 7. Get the total revenue generated from all orders
SELECT SUM(total_amount) AS total_revenue
FROM "Order";

-- 8. Retrieve all customers who placed an order in the last 30 days
SELECT c.first_name, c.last_name, o.order_date
FROM Customer c
JOIN "Order" o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '30 days';

-- 9. Retrieve the order history of a specific customer with order items (Customer ID: 1)
SELECT o.order_id, oi.product_id, oi.quantity, oi.price_at_purchase, o.order_date
FROM "Order" o
JOIN Order_Item oi ON o.order_id = oi.order_id
WHERE o.customer_id = 1;

-- 10. Find the total quantity of each product sold
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Product p
JOIN Order_Item oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- 11. Find the supplier that provides the most products
SELECT s.supplier_name, COUNT(p.product_id) AS total_products
FROM Supplier s
JOIN Product p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
ORDER BY total_products DESC
LIMIT 1;

-- 12. Retrieve the details of customers who have not placed any orders
SELECT c.first_name, c.last_name, c.email
FROM Customer c
LEFT JOIN "Order" o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 13. Retrieve the details of orders with a total amount greater than $500
SELECT order_id, customer_id, total_amount, order_date
FROM "Order"
WHERE total_amount > 500;

-- 14. Get the average price of products in each category
SELECT c.category_name, AVG(p.price) AS avg_price
FROM Product p
JOIN Category c ON p.category_id = c.category_id
GROUP BY c.category_name;

-- 15. Retrieve the details of the most recent order placed by any customer
SELECT o.order_id, o.customer_id, o.total_amount, o.order_date
FROM "Order" o
ORDER BY o.order_date DESC
LIMIT 1;

-- Nested Query 1: Retrieve the product with the highest total quantity sold
SELECT product_name, total_sold
FROM (
    SELECT p.product_name, SUM(oi.quantity) AS total_sold
    FROM Product p
    JOIN Order_Item oi ON p.product_id = oi.product_id
    GROUP BY p.product_name
) AS ProductSales
ORDER BY total_sold DESC
LIMIT 1;

-- Nested Query 2: Find customers who have placed more than one order
SELECT c.first_name, c.last_name, c.email
FROM Customer c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM "Order" o
    GROUP BY o.customer_id
    HAVING COUNT(o.order_id) > 1
);

-- Nested Query 3: Find the category with the highest average product price
SELECT category_name, avg_price
FROM (
    SELECT c.category_name, AVG(p.price) AS avg_price
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    GROUP BY c.category_name
) AS CategoryAvgPrice
ORDER BY avg_price DESC
LIMIT 1;

-- Create the Customer Log Table
CREATE TABLE Customer_Log (
    log_id SERIAL PRIMARY KEY,
    customer_id INT, 
    operation_type VARCHAR(10),  -- 'INSERT', 'UPDATE', or 'DELETE'
    log_data TEXT,  -- Description of what was changed
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of the change
    changed_by VARCHAR(100) DEFAULT session_user  -- User who made the change
);

-- Insert Trigger Function
CREATE OR REPLACE FUNCTION log_customer_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Customer_Log (customer_id, operation_type, log_data)
    VALUES (NEW.customer_id, 'INSERT', 'New customer: ' || NEW.first_name || ' ' || NEW.last_name || ', Email: ' || NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Insert Trigger
CREATE TRIGGER after_customer_insert
AFTER INSERT ON Customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_insert();

-- Update Trigger Function
CREATE OR REPLACE FUNCTION log_customer_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Customer_Log (customer_id, operation_type, log_data)
    VALUES (
        OLD.customer_id, 
        'UPDATE', 
        'Updated from: ' || OLD.first_name || ' ' || OLD.last_name || ', Email: ' || OLD.email || ' to: ' || NEW.first_name || ' ' || NEW.last_name || ', Email: ' || NEW.email
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Update Trigger
CREATE TRIGGER after_customer_update
AFTER UPDATE ON Customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_update();

-- Delete Trigger Function
CREATE OR REPLACE FUNCTION log_customer_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Customer_Log (customer_id, operation_type, log_data)
    VALUES (
        OLD.customer_id, 
        'DELETE', 
        'Deleted customer: ' || OLD.first_name || ' ' || OLD.last_name || ', Email: ' || OLD.email
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Delete Trigger
CREATE TRIGGER after_customer_delete
AFTER DELETE ON Customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_delete();

-- Create the Product Log Table
CREATE TABLE Product_Log (
    log_id SERIAL PRIMARY KEY,
    product_id INT, 
    operation_type VARCHAR(10),  -- 'INSERT', 'UPDATE', or 'DELETE'
    log_data TEXT,  -- Description of what was changed
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of the change
    changed_by VARCHAR(100) DEFAULT session_user  -- User who made the change
);

-- Insert Trigger Function
CREATE OR REPLACE FUNCTION log_product_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Product_Log (product_id, operation_type, log_data)
    VALUES (NEW.product_id, 'INSERT', 'New product: ' || NEW.product_name || ', Price: ' || NEW.price || ', Stock: ' || NEW.stock_quantity);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Insert Trigger
CREATE TRIGGER after_product_insert
AFTER INSERT ON Product
FOR EACH ROW
EXECUTE FUNCTION log_product_insert();

-- Update Trigger Function
CREATE OR REPLACE FUNCTION log_product_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Product_Log (product_id, operation_type, log_data)
    VALUES (
        OLD.product_id, 
        'UPDATE', 
        'Updated from: ' || OLD.product_name || ', Price: ' || OLD.price || ', Stock: ' || OLD.stock_quantity ||
        ' to: ' || NEW.product_name || ', Price: ' || NEW.price || ', Stock: ' || NEW.stock_quantity
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Update Trigger
CREATE TRIGGER after_product_update
AFTER UPDATE ON Product
FOR EACH ROW
EXECUTE FUNCTION log_product_update();

-- Delete Trigger Function
CREATE OR REPLACE FUNCTION log_product_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Product_Log (product_id, operation_type, log_data)
    VALUES (
        OLD.product_id, 
        'DELETE', 
        'Deleted product: ' || OLD.product_name || ', Price: ' || OLD.price || ', Stock: ' || OLD.stock_quantity
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Delete Trigger
CREATE TRIGGER after_product_delete
AFTER DELETE ON Product
FOR EACH ROW
EXECUTE FUNCTION log_product_delete();

-- 1. Add a new Customer
CREATE PROCEDURE add_customer(p_first_name VARCHAR(50), p_last_name VARCHAR(50), p_email VARCHAR(100), p_phone VARCHAR(20), p_address VARCHAR(255))
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Customer (first_name, last_name, email, phone, address)
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_address);
END;
$$;

-- 2. Update Customer's Address
CREATE PROCEDURE update_customer_address(p_customer_id INT, p_new_address VARCHAR(255))
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Customer
    SET address = p_new_address
    WHERE customer_id = p_customer_id;
END;
$$;

-- 3. Delete a Customer by ID
CREATE PROCEDURE delete_customer(p_customer_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM Customer WHERE customer_id = p_customer_id;
END;
$$;

-- 4. Add a new Product
CREATE PROCEDURE add_product(p_product_name VARCHAR(100), p_description TEXT, p_price DECIMAL(10, 2), p_stock_quantity INT, p_category_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Product (product_name, description, price, stock_quantity, category_id)
    VALUES (p_product_name, p_description, p_price, p_stock_quantity, p_category_id);
END;
$$;

-- 5. Update Product Price
CREATE PROCEDURE update_product_price(p_product_id INT, p_new_price DECIMAL(10, 2))
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Product
    SET price = p_new_price
    WHERE product_id = p_product_id;
END;
$$;

-- 6. Update Product Stock
CREATE PROCEDURE update_product_stock(p_product_id INT, p_new_stock INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Product
    SET stock_quantity = p_new_stock
    WHERE product_id = p_product_id;
END;
$$;

-- 7. Delete a Product by ID
CREATE PROCEDURE delete_product(p_product_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM Product WHERE product_id = p_product_id;
END;
$$;

-- 8. Add a new Order
CREATE PROCEDURE add_order(p_customer_id INT, p_shipping_address VARCHAR(255), p_total_amount DECIMAL(10, 2))
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO "Order" (customer_id, order_date, shipping_address, total_amount, status)
    VALUES (p_customer_id, CURRENT_DATE, p_shipping_address, p_total_amount, 'pending');
END;
$$;

-- 9. Update Order Status
CREATE PROCEDURE update_order_status(p_order_id INT, p_new_status VARCHAR(20))
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE "Order"
    SET status = p_new_status
    WHERE order_id = p_order_id;
END;
$$;

-- 10. Add an Order Item
CREATE PROCEDURE add_order_item(p_order_id INT, p_product_id INT, p_quantity INT, p_price_at_purchase DECIMAL(10, 2))
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Order_Item (order_id, product_id, quantity, price_at_purchase)
    VALUES (p_order_id, p_product_id, p_quantity, p_price_at_purchase);
END;
$$;

-- 11. Delete an Order by ID
CREATE PROCEDURE delete_order(p_order_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM "Order"
    WHERE order_id = p_order_id;
END;
$$;

-- 12. Update Payment for an Order
CREATE PROCEDURE update_order_payment(p_order_id INT, p_payment_method VARCHAR(50), p_amount_paid DECIMAL(10, 2))
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Payment (order_id, payment_date, payment_method, amount_paid)
    VALUES (p_order_id, CURRENT_DATE, p_payment_method, p_amount_paid)
    ON CONFLICT (order_id) DO UPDATE 
    SET payment_method = EXCLUDED.payment_method, amount_paid = EXCLUDED.amount_paid;
END;
$$;

-- 13. Add a new Manager
CREATE PROCEDURE add_manager(p_first_name VARCHAR(50), p_last_name VARCHAR(50), p_email VARCHAR(100), p_phone VARCHAR(20), p_role VARCHAR(50))
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Manager (first_name, last_name, email, phone, role)
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_role);
END;
$$;

-- 14. Update Manager's Role
CREATE PROCEDURE update_manager_role(p_manager_id INT, p_new_role VARCHAR(50))
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Manager
    SET role = p_new_role
    WHERE manager_id = p_manager_id;
END;
$$;

-- 15. Delete a Manager by ID
CREATE PROCEDURE delete_manager(p_manager_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM Manager WHERE manager_id = p_manager_id;
END;
$$;

-- 16. Add Product with Transaction and ROLLBACK
CREATE OR REPLACE PROCEDURE add_product_with_rollback(
    p_product_name VARCHAR(100), 
    p_description TEXT, 
    p_price DECIMAL(10, 2), 
    p_stock_quantity INT, 
    p_category_id INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Start the transaction
    BEGIN
        -- Insert into Product table
        INSERT INTO Product (product_name, description, price, stock_quantity, category_id)
        VALUES (p_product_name, p_description, p_price, p_stock_quantity, p_category_id);

        -- Update stock (for demonstration, let's assume we update the stock in another related table)
        UPDATE Stock SET total_stock = total_stock + p_stock_quantity WHERE category_id = p_category_id;

        -- If both succeed, commit the transaction
        COMMIT;

    EXCEPTION
        -- On error, roll back all changes
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed, changes have been rolled back.';
    END;
END;
$$;


-- 17. Place Order with Transaction and ROLLBACK
CREATE OR REPLACE PROCEDURE place_order_with_rollback(
    p_customer_id INT, 
    p_shipping_address VARCHAR(255), 
    p_total_amount DECIMAL(10, 2), 
    p_order_items JSONB  -- Assume we pass order items as a JSON array
)
LANGUAGE plpgsql AS $$
DECLARE
    new_order_id INT;
BEGIN
    -- Start the transaction
    BEGIN
        -- Insert into Order table
        INSERT INTO "Order" (customer_id, order_date, shipping_address, total_amount, status)
        VALUES (p_customer_id, CURRENT_DATE, p_shipping_address, p_total_amount, 'pending')
        RETURNING order_id INTO new_order_id;

        -- Loop through order items and insert each one
        FOR item IN SELECT * FROM jsonb_array_elements(p_order_items) LOOP
            INSERT INTO Order_Item (order_id, product_id, quantity, price_at_purchase)
            VALUES (new_order_id, item->>'product_id', (item->>'quantity')::INT, (item->>'price_at_purchase')::DECIMAL);
        END LOOP;

        -- If everything succeeds, commit the transaction
        COMMIT;

    EXCEPTION
        -- On any error, roll back the changes
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed, changes have been rolled back.';
    END;
END;
$$;

-- 1. Create a view for customer orders
CREATE VIEW Customer_Orders_View AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM Customer c
JOIN "Order" o ON c.customer_id = o.customer_id;

-- 2. Create a view for product sales
CREATE VIEW Product_Sales_View AS
SELECT 
    p.product_id,
    p.product_name,
    p.price,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.price_at_purchase * oi.quantity) AS total_sales
FROM Product p
JOIN Order_Item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.price;

-- 3. Create a view for order details
CREATE VIEW Order_Details_View AS
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    oi.product_id,
    p.product_name,
    oi.quantity,
    oi.price_at_purchase
FROM "Order" o
JOIN Order_Item oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id;