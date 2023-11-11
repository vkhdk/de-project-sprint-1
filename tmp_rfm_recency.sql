-- query for test
/*
WITH sub_t_cl_ord_2022 AS
  (SELECT *
   FROM analysis.orders o
   LEFT JOIN analysis.orderstatuses o2 ON o.status = o2.id
   WHERE o2.key = 'Closed'
     AND o.order_ts >= '2022-01-01'
     AND o.order_ts < '2023-01-01' ),
     sub_t_cl_ord_2022_agg AS
  (SELECT u.id,
          min(cl_o_22.order_ts) AS last_order_dt
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id
   GROUP BY u.id),
     sub_t_cl_ord_2022_agg_fill_null AS
  (SELECT id,
          CASE
              WHEN last_order_dt IS NULL THEN '1900-01-01'
              ELSE last_order_dt
          END
   FROM sub_t_cl_ord_2022_agg),
     test_t AS
  (SELECT id,
          ntile(5) OVER w AS recency
   FROM sub_t_cl_ord_2022_agg_fill_null WINDOW w AS (
                                                     ORDER BY last_order_dt ASC))
SELECT count(*)
FROM test_t
GROUP BY recency;
*/
-- query for recency metric
INSERT INTO analysis.tmp_rfm_recency (user_id, recency) WITH sub_t_cl_ord_2022 AS
  (SELECT *
   FROM analysis.orders o
   LEFT JOIN analysis.orderstatuses o2 ON o.status = o2.id
   WHERE o2.key = 'Closed'
     AND o.order_ts >= '2022-01-01'
     AND o.order_ts < '2023-01-01' ),
                                                             sub_t_cl_ord_2022_agg AS
  (SELECT u.id,
          min(cl_o_22.order_ts) AS last_order_dt
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id
   GROUP BY u.id),
                                                             sub_t_cl_ord_2022_agg_fill_null AS
  (SELECT id,
          CASE
              WHEN last_order_dt IS NULL THEN '1900-01-01'
              ELSE last_order_dt
          END
   FROM sub_t_cl_ord_2022_agg)
SELECT id,
       ntile(5) OVER w AS recency
FROM sub_t_cl_ord_2022_agg_fill_null WINDOW w AS (
                                                  ORDER BY last_order_dt ASC);