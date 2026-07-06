-- ============================================================
-- Script for insert data into tables in bd_gustavo_guzman_micaela
-- ============================================================

USE bd_gustavo_guzman_micaela;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO riwi_city (id, name) VALUES
(1, 'Cartagena'),
(2, 'Barranquilla'),
(3, 'Santa Marta');

INSERT INTO riwi_supplier (id, name, city_id) VALUES
(1, 'Aceros del Norte S.A.S', 1),
(2, 'Industriales S.A.S', 2),
(3, 'Suministros Global S.A.S', 3);

INSERT INTO riwi_category (id, name) VALUES
(1, 'Herramientas'),
(2, 'Consumibles'),
(3, 'Elementos de Proteccion Personal');

INSERT INTO riwi_product (id, name, category_id) VALUES
(1, 'Disco de Corte 4.5', 1),
(2, 'Electrodo E6013', 2),
(3, 'Guante de Nitrilo', 3),
(4, 'Casco Industrial', 3);

INSERT INTO riwi_warehouse (id, name, city_id) VALUES
(1, 'Bodega Costa', 3),
(2, 'Bodega Central', 2),
(3, 'Centro Logistico Norte', 1);

INSERT INTO riwi_purchase (id, po_number, supplier_id, purchase_date) VALUES
(1, 'PO-1022', 2, '2026-01-01'),
(2, 'PO-1041', 1, '2026-02-14'),
(3, 'PO-1075', 1, '2026-02-16'),
(4, 'PO-1094', 2, '2026-03-12'),
(5, 'PO-1032', 3, '2026-04-17'),
(6, 'PO-1034', 2, '2026-04-26'),
(7, 'PO-1040', 1, '2026-05-23');

INSERT INTO riwi_purchase_detail (id, purchase_id, product_id, quantity, unit_price) VALUES
(1, 1, 3, 70, 14290),
(2, 2, 2, 27, 35506),
(3, 3, 3, 160, 117524),
(4, 4, 1, 124, 52910),
(5, 5, 3, 185, 123653),
(6, 6, 1, 61, 136736),
(7, 7, 3, 175, 39944);

INSERT INTO riwi_inventory_movement (id, product_id, warehouse_id, movement_date, movement_type, quantity, unit_price, purchase_id) VALUES
(1, 1, 1, '2026-04-01', 'OUT', 148, 115388, NULL),
(2, 2, 1, '2026-02-14', 'IN', 27, 35506, 2),
(3, 3, 1, '2026-01-01', 'IN', 70, 14290, 1),
(4, 3, 3, '2026-02-16', 'IN', 160, 117524, 3),
(5, 2, 2, '2026-02-28', 'OUT', 40, 139836, NULL),
(6, 1, 2, '2026-03-06', 'OUT', 130, 88512, NULL),
(7, 2, 2, '2026-01-20', 'OUT', 33, 43746, NULL),
(8, 3, 1, '2026-04-13', 'OUT', 119, 23022, NULL),
(9, 3, 2, '2026-04-17', 'IN', 185, 123653, 5),
(10, 2, 2, '2026-02-02', 'OUT', 87, 123108, NULL),
(11, 3, 1, '2026-05-23', 'IN', 175, 39944, 7),
(12, 1, 2, '2026-03-19', 'OUT', 199, 118291, NULL),
(13, 3, 3, '2026-01-25', 'OUT', 131, 71980, NULL),
(14, 1, 1, '2026-03-15', 'OUT', 134, 89964, NULL),
(15, 1, 2, '2026-03-12', 'IN', 124, 52910, 4),
(16, 1, 2, '2026-04-26', 'IN', 61, 136736, 6),
(17, 1, 3, '2026-03-03', 'OUT', 169, 18022, NULL),
(18, 4, 1, '2026-03-21', 'OUT', 192, 108802, NULL),
(19, 2, 3, '2026-03-11', 'OUT', 78, 37943, NULL);

SET FOREIGN_KEY_CHECKS = 1;