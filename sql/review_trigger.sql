DROP TRIGGER IF EXISTS before_insert_review;

DELIMITER $$

CREATE TRIGGER before_insert_review
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
    DECLARE order_count INT;

    SELECT COUNT(*) INTO order_count
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = NEW.customer_id
      AND oi.product_id = NEW.product_id;

    IF order_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Customer has not purchased this product, so they cannot review it.';
    END IF;
END $$

DELIMITER ;
