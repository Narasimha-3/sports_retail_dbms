DROP PROCEDURE IF EXISTS CheckStockDemandMismatch;
DELIMITER $$

CREATE PROCEDURE CheckStockDemandMismatch()
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold,
        CASE 
            WHEN p.stock_quantity > (SUM(oi.quantity) * 2) THEN 'Overstocked'
            WHEN p.stock_quantity < (SUM(oi.quantity) * 0.5) THEN 'Understocked'
            ELSE 'Balanced'
        END AS stock_status
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING stock_status != 'Balanced';
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS GetLowStockProducts;
DELIMITER $$

CREATE PROCEDURE GetLowStockProducts(IN min_stock INT)
BEGIN
    SELECT 
        product_id, 
        name, 
        stock_quantity 
    FROM products
    WHERE stock_quantity < min_stock;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS GetOverstockedSlowMovers;
DELIMITER $$

CREATE PROCEDURE GetOverstockedSlowMovers(IN min_sales INT, IN max_stock INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING total_sold < min_sales AND stock_quantity > max_stock;
END $$

DELIMITER ;

