DROP PROCEDURE IF EXISTS GetProductReviews;

DELIMITER $$

CREATE PROCEDURE GetProductReviews(
    IN product_id_param INT,
    IN sort_order_param VARCHAR(4)
)
BEGIN
    IF sort_order_param NOT IN ('ASC', 'DESC') THEN
        SET sort_order_param = 'DESC';
    END IF;

    SELECT review_id, product_id, customer_id, 
           COALESCE(rating, 0) AS rating,
           review_text, created_at
    FROM reviews
    WHERE product_id = product_id_param
    ORDER BY rating IS NULL, rating * 1
    COLLATE utf8mb4_general_ci, rating * (CASE WHEN sort_order_param = 'ASC' THEN 1 ELSE -1 END);
END $$

DELIMITER ;
