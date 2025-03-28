DROP TRIGGER IF EXISTS after_delete_product_discounts;
DROP TRIGGER IF EXISTS before_delete_product_reviews;
DROP TRIGGER IF EXISTS before_delete_product_order_items;

DELIMITER $$

CREATE TRIGGER after_delete_product_discounts
AFTER DELETE ON products
FOR EACH ROW
BEGIN
    DELETE FROM discounts WHERE product_id = OLD.product_id;
END $$

CREATE TRIGGER before_delete_product_reviews
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    DELETE FROM reviews WHERE product_id = OLD.product_id;
END $$

CREATE TRIGGER before_delete_product_order_items
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    DELETE FROM order_items WHERE product_id = OLD.product_id;
END $$

DELIMITER ;
