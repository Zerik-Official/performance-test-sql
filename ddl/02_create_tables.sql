-- =============================================================================
-- City category
CREATE TABLE if not exists riwi_city (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name varchar(80) NOT NULL,
    CONSTRAINT uq_riwi_city_name UNIQUE (name)
) ENGINE = InnoDB;

-- =============================================================================
-- Suppliers
CREATE TABLE if not exists riwi_supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    city_id INT NOT NULL,
    CONSTRAINT uq_riwi_supplier_name UNIQUE (name),
    CONSTRAINT fk_riwi_supplier_city
        FOREIGN KEY (city_id) REFERENCES riwi_city (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- =============================================================================
-- Product categories
CREATE TABLE if not exists riwi_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT uq_riwi_category_name UNIQUE (name)
) ENGINE = InnoDB;

-- =============================================================================
-- Products
CREATE TABLE if not exists riwi_product (
    id  INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT uq_riwi_product_name UNIQUE (name),
    CONSTRAINT fk_riwi_product_category
        FOREIGN KEY (category_id) REFERENCES riwi_category (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- =============================================================================
-- Warehouse
CREATE TABLE if not exists riwi_warehouse (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(150) NOT NULL,
    city_id      INT NOT NULL,
    CONSTRAINT uq_riwi_warehouse_name UNIQUE (name),
    CONSTRAINT fk_riwi_warehouse_city
        FOREIGN KEY (city_id) REFERENCES riwi_city (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- =============================================================================
-- Riwi purchase
CREATE TABLE if not exists riwi_purchase (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    po_number     VARCHAR(20) NOT NULL,
    supplier_id   INT NOT NULL,
    purchase_date DATE NOT NULL,
    CONSTRAINT fk_riwi_purchase_supplier
        FOREIGN KEY (supplier_id) REFERENCES riwi_supplier (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE INDEX idx_riwi_purchase_po_number ON riwi_purchase (po_number);

-- =============================================================================
-- Riwi purchase details
CREATE TABLE if not exists riwi_purchase_detail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id         INT NOT NULL,
    product_id           INT NOT NULL,
    quantity             INT NOT NULL,
    unit_price           DECIMAL(12,2) NOT NULL,
    CONSTRAINT uq_riwi_purchase_detail UNIQUE (purchase_id, product_id),
    CONSTRAINT ck_riwi_purchase_detail_qty CHECK (quantity > 0),
    CONSTRAINT ck_riwi_purchase_detail_price CHECK (unit_price >= 0),
    CONSTRAINT fk_riwi_purchase_detail_purchase
        FOREIGN KEY (purchase_id) REFERENCES riwi_purchase (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_riwi_purchase_detail_product
        FOREIGN KEY (product_id) REFERENCES riwi_product (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

-- =============================================================================
-- Riwi inventory movement
CREATE TABLE if not exists riwi_inventory_movement (
    movement_id    INT AUTO_INCREMENT PRIMARY KEY,
    product_id     INT NOT NULL,
    warehouse_id   INT NOT NULL,
    movement_date  DATE NOT NULL,
    movement_type  ENUM('IN', 'OUT') NOT NULL,
    quantity       INT NOT NULL,
    unit_price     DECIMAL(12,2) NOT NULL,
    purchase_id    INT NULL,
    CONSTRAINT ck_riwi_movement_qty CHECK (quantity > 0),
    CONSTRAINT ck_riwi_movement_price CHECK (unit_price >= 0),
    CONSTRAINT fk_riwi_movement_product
        FOREIGN KEY (product_id) REFERENCES riwi_product (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_riwi_movement_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES riwi_warehouse (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_riwi_movement_purchase
        FOREIGN KEY (purchase_id) REFERENCES riwi_purchase (id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE = InnoDB;

CREATE INDEX idx_riwi_movement_product ON riwi_inventory_movement (product_id);
CREATE INDEX idx_riwi_movement_warehouse ON riwi_inventory_movement (warehouse_id);
CREATE INDEX idx_riwi_movement_type ON riwi_inventory_movement (movement_type);
