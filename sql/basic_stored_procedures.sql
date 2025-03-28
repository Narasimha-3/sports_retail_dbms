DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT product_id, name FROM Products;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllCategories;

DELIMITER //

CREATE PROCEDURE GetAllCategories()
BEGIN
    SELECT category_id, category_name FROM Categories;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS GetWholeCategory;

DELIMITER //

CREATE PROCEDURE GetWholeCategory(IN cat_id INT)
BEGIN
    SELECT * FROM Categories WHERE category_id = cat_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS EditCategory;

DELIMITER //

CREATE PROCEDURE EditCategory(
    IN cat_id INT, 
    IN cat_name VARCHAR(100), 
    IN cat_desc TEXT
)
BEGIN
    UPDATE Categories 
    SET category_name = cat_name, 
        description = cat_desc 
    WHERE category_id = cat_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS GetProductDetails;

DELIMITER //

CREATE PROCEDURE GetProductDetails(IN prod_id INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name AS product_name, 
        p.price, 
        p.stock_quantity, 
        c.category_name, 
        s.name AS supplier_name, 
        s.contact_email, 
        s.phone 
    FROM Products p
    JOIN Categories c ON p.category_id = c.category_id
    JOIN Suppliers s ON p.supplier_id = s.supplier_id
    WHERE p.product_id = prod_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS GetWholeProduct;

DELIMITER //

CREATE PROCEDURE GetWholeProduct(IN prod_id INT)
BEGIN
    SELECT * FROM Products WHERE product_id = prod_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS EditProduct;

DELIMITER //

CREATE PROCEDURE EditProduct(
    IN prod_id INT,
    IN prod_name VARCHAR(100),
    IN prod_price DECIMAL(10,2),
    IN prod_stock INT,
    IN prod_category INT,
    IN prod_supplier INT
)
BEGIN
    UPDATE Products 
    SET name = prod_name, 
        price = prod_price, 
        stock_quantity = prod_stock, 
        category_id = prod_category, 
        supplier_id = prod_supplier 
    WHERE product_id = prod_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS AddStock;

DELIMITER //

CREATE PROCEDURE AddStock(
    IN prod_id INT,
    IN stock_amount INT
)
BEGIN
    UPDATE Products 
    SET stock_quantity = stock_quantity + stock_amount
    WHERE product_id = prod_id;
END;
//

DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllDiscounts;

DELIMITER //

CREATE PROCEDURE GetAllDiscounts()
BEGIN
    SELECT d.discount_id, d.product_id, d.discount_percentage, d.start_date, d.end_date, p.name AS product_name
    FROM discounts d
    JOIN Products p ON d.product_id = p.product_id;
END;
//

DELIMITER ;



