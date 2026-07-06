-- =============================================================================
-- RiwiSupply S.A.S - Business Queries
-- =============================================================================

--------------------------------------------------------------------------------
-- Query 1: Available stock by product
-- Requirement: As the inventory manager, I need to know the
-- current stock levels for each product to plan purchases.
-- Stock = sum(IN) - sum(OUT)
--------------------------------------------------------------------------------
SELECT
    p.id,
    p.name AS product_name,
    COALESCE(SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity ELSE 0 END), 0)
        - COALESCE(SUM(CASE WHEN m.movement_type = 'OUT' THEN m.quantity ELSE 0 END), 0) AS available_stock
FROM riwi_product p
LEFT JOIN riwi_inventory_movement m ON m.product_id = p.id
GROUP BY p.id, p.name
ORDER BY p.name;

----------------------------------------------------------------------
-- Query 2: Inventory movements with product and warehouse details.
-- Requirement: As a logistics supervisor, I need to know the
-- movements made in each warehouse and the products involved.
----------------------------------------------------------------------
SELECT
    m.movement_id AS id,
    m.movement_date,
    m.movement_type,
    p.name AS product_name,
    w.name AS warehouse_name,
    c.name AS warehouse_city,
    m.quantity,
    m.unit_price,
    (m.quantity * m.unit_price) AS total_value
FROM riwi_inventory_movement m
JOIN riwi_product p ON p.id = m.product_id
JOIN riwi_warehouse w ON w.id = m.warehouse_id
JOIN riwi_city c ON c.id = w.city_id
ORDER BY m.movement_date;


-- ------------------------------------------------------------
-- Query 3: Total purchased by supplier
-- Requirement: As the purchasing manager, I need to identify
-- how much has been purchased from each supplier.
-- ------------------------------------------------------------
SELECT
    s.id AS supplier_id,
    s.name AS supplier_name,
    COUNT(DISTINCT pu.id) AS total_purchases,
    SUM(pd.quantity * pd.unit_price) AS total_purchased_value
FROM riwi_supplier s
JOIN riwi_purchase pu ON pu.supplier_id = s.id
JOIN riwi_purchase_detail pd ON pd.purchase_id = pu.id
GROUP BY s.id, s.name
ORDER BY total_purchased_value DESC;

------------------------------------------------------------
-- Query 4: Number of recorded movements by warehouse
-- Requirement: As an operations manager, I need to know
-- which warehouses show the highest activity.
------------------------------------------------------------
SELECT
    w.id AS warehouse_id,
    w.name AS warehouse_name,
    COUNT(m.movement_id) AS total_movements
FROM riwi_warehouse w
LEFT JOIN riwi_inventory_movement m ON m.warehouse_id = w.id
GROUP BY w.id, w.name
ORDER BY total_movements DESC;


-- ------------------------------------------------------------
-- Query 5: Product with the highest purchase volume
-- Requirement: As an analyst, I need to identify the
-- product that generates the highest turnover within the organization.
-- ------------------------------------------------------------
SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(pd.quantity) AS total_purchased_quantity
FROM riwi_product p
JOIN riwi_purchase_detail pd ON pd.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_purchased_quantity DESC
LIMIT 1;


-- ------------------------------------------------------------
-- Query 6: Total value of stored inventory by warehouse
-- Requirement: As operations manager, I need to know the
-- economic value of the inventory distributed across each warehouse.
-- Value = sum(IN * price) - sum(OUT * price) per warehouse
-- ------------------------------------------------------------
SELECT
    w.id AS warehouse_id,
    w.name AS warehouse_name,
    COALESCE(SUM(CASE WHEN m.movement_type = 'IN' THEN m.quantity * m.unit_price ELSE 0 END), 0)
        - COALESCE(SUM(CASE WHEN m.movement_type = 'OUT' THEN m.quantity * m.unit_price ELSE 0 END), 0) AS inventory_value
FROM riwi_warehouse w
LEFT JOIN riwi_inventory_movement m ON m.warehouse_id = w.id
GROUP BY w.id, w.name
ORDER BY inventory_value DESC;
