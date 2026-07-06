-- =============================================================================

-- ------------------------------------------------------------
-- View 1: riwi_vw_stock_by_product
-- Operational use: check the available stock of each
-- product at any time without manual recalculation.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW riwi_vw_stock_by_product AS
SELECT
    p.id AS product_id,
    p.name AS product_name,
    cat.name AS category_name,
    COALESCE(SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE 0 END), 0)
        - COALESCE(SUM(CASE WHEN m.movement_type = 'OUT' THEN m.quantity ELSE 0 END), 0) AS available_stock
FROM riwi_product p
LEFT JOIN riwi_category cat ON cat.id = p.category_id
LEFT JOIN riwi_inventory_movement m ON m.product_id = p.id
GROUP BY p.id, p.name, cat.name;

-- Usage: SELECT * FROM riwi_vw_stock_by_product ORDER BY available_stock DESC;

-- ------------------------------------------------------------
-- View 2: riwi_vw_purchases_by_supplier
-- Analytical use: summary of purchase value and number of orders
-- by supplier, for purchasing reports.
-- ------------------------------------------------------------
CREATE OR REPLACE VIEW riwi_vw_purchases_by_supplier AS
SELECT
    s.id AS supplier_id,
    s.name AS supplier_name,
    c.name AS supplier_city,
    COUNT(DISTINCT pu.id) AS total_purchases,
    SUM(pd.quantity) AS total_units_purchased,
    SUM(pd.quantity * pd.unit_price) AS total_purchased_value
FROM riwi_supplier s
JOIN riwi_city c ON c.id = s.city_id
JOIN riwi_purchase pu ON pu.supplier_id = s.id
JOIN riwi_purchase_detail pd ON pd.purchase_id = pu.id
GROUP BY s.id, s.name, c.name;

-- Usage: SELECT * FROM riwi_vw_purchases_by_supplier ORDER BY total_purchased_value DESC;
