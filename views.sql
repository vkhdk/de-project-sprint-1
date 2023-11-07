-- analysis.orderitems
CREATE MATERIALIZED VIEW analysis.orderitems AS
SELECT ord.id,
       ord.product_id,
       ord.order_id,
       ord."name",
       ord.price,
       ord.discount,
       ord.quantity
FROM production.orderitems AS ord;

-- analysis.orders
CREATE MATERIALIZED VIEW analysis.orders AS
SELECT ordr.order_id,
       ordr.order_ts,
       ordr.user_id,
       ordr.bonus_payment,
       ordr.payment,
       ordr."cost",
       ordr.bonus_grant,
       ordr.status
FROM production.orders AS ordr;

-- analysis.orderstatuses
CREATE MATERIALIZED VIEW analysis.orderstatuses AS
SELECT ords.id,
       ords.key
FROM production.orderstatuses AS ords;

-- analysis.orderstatuslog
CREATE MATERIALIZED VIEW analysis.orderstatuslog AS
SELECT ordsl.id,
       ordsl.order_id,
       ordsl.status_id,
       ordsl.dttm
FROM production.orderstatuslog AS ordsl;

-- analysis.products
CREATE MATERIALIZED VIEW analysis.products AS
SELECT prd.id,
       prd.name,
       prd.price
FROM production.products AS prd;

-- analysis.users
CREATE MATERIALIZED VIEW analysis.users AS
SELECT usr.id,
       usr.name,
       usr.login
FROM production.users AS usr;
