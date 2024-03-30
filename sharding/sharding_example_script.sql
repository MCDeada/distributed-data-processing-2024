CREATE TABLE inventory (
    id SERIAL NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER
) PARTITION BY RANGE (product_id);

CREATE TABLE inventory_partitioned (
    CHECK (product_id = ANY (ARRAY[1, 2, 3]))
) INHERITS (inventory);

CREATE TABLE inventory_prod1 PARTITION OF inventory FOR VALUES FROM (1) TO (2);
CREATE TABLE inventory_prod2 PARTITION OF inventory FOR VALUES FROM (2) TO (3);
CREATE TABLE inventory_prod3 PARTITION OF inventory FOR VALUES FROM (3) TO (4);

INSERT INTO inventory (product_id, quantity)
VALUES (1, 100), (2, 200), (3, 300);

SELECT *, 'inventory_prod1' as tableName FROM inventory_prod1;
SELECT *, 'inventory_prod2' as tableName FROM inventory_prod2;
SELECT *, 'inventory_prod3' as tableName FROM inventory_prod3;
SELECT *, 'inventory' as tableName FROM inventory;