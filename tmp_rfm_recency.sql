-- query for test
/*
WITH sub_t AS
  (SELECT u.id,
          min(o.order_ts) AS last_order_dt
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
     sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN last_order_dt IS NULL THEN '1900-01-01'
              ELSE last_order_dt
          END
   FROM sub_t),
     recency_sub_t_fill_nulls AS
  (SELECT ntile(5) OVER w AS recency,
                        id,
                        last_order_dt
   FROM sub_t_fill_nulls WINDOW w AS (
                                      ORDER BY last_order_dt ASC)
   ORDER BY last_order_dt ASC)
SELECT count(*)
FROM recency_sub_t_fill_nulls
GROUP BY recency;
*/
-- query for recency metric
INSERT INTO analysis.tmp_rfm_recency (user_id, recency) WITH sub_t AS
  (SELECT u.id,
          min(o.order_ts) AS last_order_dt
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
                                                             sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN last_order_dt IS NULL THEN '1900-01-01'
              ELSE last_order_dt
          END
   FROM sub_t)
SELECT id,
       ntile(5) OVER w AS recency
FROM sub_t_fill_nulls WINDOW w AS (
                                   ORDER BY last_order_dt ASC)
ORDER BY last_order_dt ASC;