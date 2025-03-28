DROP PROCEDURE IF EXISTS GetPricingTrends;
DELIMITER //
CREATE PROCEDURE GetPricingTrends()
BEGIN
    SELECT p.product_id, p.name, p.price, AVG(oi.unit_price) AS avg_selling_price,
           COUNT(oi.order_id) AS total_orders
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.price
    ORDER BY total_orders DESC;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS OptimizeDiscounts;
DELIMITER //
CREATE PROCEDURE OptimizeDiscounts(
    IN base_discount DECIMAL(5,2), 
    IN bulk_discount DECIMAL(5,2),
    IN low_demand_discount DECIMAL(5,2)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE pstock INT;
    DECLARE psales INT;
    DECLARE current_price DECIMAL(10,2);
    DECLARE discount_percent DECIMAL(5,2);
    DECLARE discounted_price DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR 
        SELECT p.product_id, p.stock_quantity, p.price, 
               COALESCE(SUM(oi.quantity), 0) AS total_sales
        FROM products p
        LEFT JOIN order_items oi ON p.product_id = oi.product_id
        GROUP BY p.product_id, p.stock_quantity, p.price;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO pid, pstock, current_price, psales;
        IF done THEN LEAVE read_loop; END IF;

        SET discount_percent = GREATEST(
            CASE WHEN pstock > 100 THEN bulk_discount ELSE 0 END,
            CASE WHEN psales < 10 THEN low_demand_discount ELSE 0 END,
            base_discount
        );
        SET discounted_price = current_price * (1 - discount_percent / 100);
        UPDATE products SET price = discounted_price WHERE product_id = pid;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS ApplyDynamicPricing;
DELIMITER //
CREATE PROCEDURE ApplyDynamicPricing(
    IN demand_factor DECIMAL(5,2)
)
BEGIN
    UPDATE products p
    JOIN (
        SELECT oi.product_id, COUNT(oi.order_id) AS total_orders
        FROM order_items oi
        GROUP BY oi.product_id
    ) AS order_stats
    ON p.product_id = order_stats.product_id
    SET p.price = p.price * (1 + (order_stats.total_orders / 100) * demand_factor);
END //
DELIMITER ;