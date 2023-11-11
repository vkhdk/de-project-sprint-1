WITH sub_t_log_status AS
  (SELECT *,
          ROW_NUMBER() OVER (PARTITION BY o.order_id
                             ORDER BY o.dttm DESC) AS rn
   FROM production.orderstatuslog o),
     sub_t_last_status AS
  (SELECT sub_t_log_status.order_id,
          sub_t_log_status.status_id
   FROM sub_t_log_status
   WHERE sub_t_log_status.rn = 1)
SELECT ordr.order_id,
       ordr.order_ts,
       ordr.user_id,
       ordr.bonus_payment,
       ordr.payment,
       ordr."cost",
       ordr.bonus_grant,
       sbt_ls.status_id AS status
FROM production.orders ordr
LEFT JOIN sub_t_last_status sbt_ls ON ordr.order_id = sbt_ls.order_id;