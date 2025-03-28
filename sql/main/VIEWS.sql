CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `max_discounts` AS
    SELECT 
        `d`.`product_id` AS `product_id`,
        COALESCE(MAX(`d`.`discount_percentage`), 0) AS `max_discount`
    FROM
        (`discounts` `d`
        JOIN `orders` `o` ON ((`o`.`order_date` BETWEEN `d`.`start_date` AND `d`.`end_date`)))
    GROUP BY `d`.`product_id` , `o`.`order_date`