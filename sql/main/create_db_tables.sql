CREATE DATABASE sports_retail;
USE sports_retail;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'marketing_analyst', 'sales_manager', 'customer_support') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS complaints;

CREATE TABLE complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    complaint TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);


CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    rating DECIMAL(3,2) CHECK (rating BETWEEN 0 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);


CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(3,2) CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE TABLE Discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    discount_percentage DECIMAL(5,2) CHECK (discount_percentage BETWEEN 0 AND 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);


CREATE INDEX idx_product_name ON Products(name);
CREATE INDEX idx_stock_level ON Products(stock_quantity);
CREATE INDEX idx_order_date ON Orders(order_date);
CREATE INDEX idx_review_product ON Reviews(product_id);
CREATE INDEX idx_order_customer ON Orders(customer_id);


DELIMITER //
CREATE TRIGGER update_product_rating
AFTER INSERT ON Reviews
FOR EACH ROW
BEGIN
    UPDATE Products
    SET rating = (SELECT AVG(rating) FROM Reviews WHERE product_id = NEW.product_id)
    WHERE product_id = NEW.product_id;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetTopSellingProducts()
BEGIN
    SELECT p.product_id, p.name, SUM(oi.quantity) AS total_sold
    FROM Order_Items oi
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.name
    ORDER BY total_sold DESC
    LIMIT 10;
END;
//
DELIMITER ;


CREATE USER 'marketing_analyst'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON sports_retail.* TO 'marketing_analyst'@'localhost';

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_pass';
GRANT ALL PRIVILEGES ON sports_retail.* TO 'admin'@'localhost';


