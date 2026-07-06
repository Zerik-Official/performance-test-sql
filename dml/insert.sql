-- =============================================================================
-- RiwiSupply S.A.S - insercion
-- =============================================================================

START TRANSACTION;

-- 1. Insert City (Ignored automatically if 'Monteria' exists)
INSERT IGNORE INTO riwi_city (name) 
VALUES ('Monteria');

-- 2. Insert Supplier linked to the City ID
INSERT INTO riwi_supplier (name, city_id)
SELECT 'Ferreteria del Sinu S.A.S', id
FROM riwi_city
WHERE name = 'Monteria'
ON DUPLICATE KEY UPDATE city_id = VALUES(city_id);

-- 3. Insert Category (Ignored automatically if 'Ferreteria' exists)
INSERT IGNORE INTO riwi_category (name) 
VALUES ('Ferreteria');

-- 4. Insert Product linked to the Category ID
INSERT INTO riwi_product (name, category_id)
SELECT 'Taladro Percutor 1/2', id
FROM riwi_category
WHERE name = 'Ferreteria'
ON DUPLICATE KEY UPDATE category_id = VALUES(category_id);

COMMIT;
