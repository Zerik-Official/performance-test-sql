-- =============================================================================
-- RiwiSupply S.A.S - Updates
-- =============================================================================
UPDATE riwi_supplier s
JOIN riwi_city c ON c.name = 'Barranquilla'
SET s.ID = c.id
WHERE s.name = 'Suministros Global S.A.S';
