-- =============================================================================
-- RiwiSupply S.A.S - delete
-- =============================================================================
DELETE p
FROM riwi_product p
WHERE p.name = 'Taladro Percutor 1/2'
  AND NOT EXISTS (
      SELECT 1 FROM riwi_inventory_movement m WHERE m.product_id = p.id
  )
  AND NOT EXISTS (
      SELECT 1 FROM riwi_purchase_detail pd WHERE pd.product_id = p.id
  );
