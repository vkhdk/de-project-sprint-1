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
          count(cl_o_22.order_id) AS order_count
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id
   GROUP BY u.id),
     test_t AS
  (SELECT id,
          ntile(5) OVER w AS frequency
   FROM sub_t_cl_ord_2022_agg WINDOW w AS (
                                           ORDER BY order_count ASC))
SELECT count(*)
FROM test_t
GROUP BY frequency;
*/
-- query for frequency metric
INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency) WITH sub_t_cl_ord_2022 AS
  (SELECT *
   FROM analysis.orders o
   LEFT JOIN analysis.orderstatuses o2 ON o.status = o2.id
   WHERE o2.key = 'Closed'
     AND o.order_ts >= '2022-01-01'
     AND o.order_ts < '2023-01-01' ),
                                                                 sub_t_cl_ord_2022_agg AS
  (SELECT u.id,
          count(cl_o_22.order_id) AS order_count
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id
   GROUP BY u.id)
SELECT id,
       ntile(5) OVER w AS frequency
FROM sub_t_cl_ord_2022_agg WINDOW w AS (
                                        ORDER BY order_count ASC);