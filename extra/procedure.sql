
DROP PROCEDURE IF EXISTS riwi_sp_get_supplier;

DELIMITER $$

CREATE PROCEDURE riwi_sp_get_supplier(IN p_supplier_id INT)
BEGIN
    SELECT
        s.id AS supplier_id,
        s.name AS supplier_name,
        c.name AS city_name
    FROM riwi_supplier s
    JOIN riwi_city c ON c.id = s.city_id
    WHERE p_supplier_id IS NULL
       OR s.id = p_supplier_id;
END $$

DELIMITER ;