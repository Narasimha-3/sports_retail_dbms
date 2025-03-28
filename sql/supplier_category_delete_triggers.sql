DROP TRIGGER IF EXISTS before_delete_supplier;
DROP TRIGGER IF EXISTS before_delete_category;

DELIMITER $$

CREATE TRIGGER before_delete_supplier
BEFORE DELETE ON suppliers
FOR EACH ROW
BEGIN
    DELETE FROM products WHERE supplier_id = OLD.supplier_id;
END $$

CREATE TRIGGER before_delete_category
BEFORE DELETE ON categories
FOR EACH ROW
BEGIN
    DELETE FROM products WHERE category_id = OLD.category_id;
END $$

DELIMITER ;
