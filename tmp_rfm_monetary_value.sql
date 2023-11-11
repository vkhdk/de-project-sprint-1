-- query for test
/*
WITH sub_t_cl_ord_2022 AS
  (SELECT *
   FROM analysis.orders o
   LEFT JOIN analysis.orderstatuses o2 ON o.status = o2.id
   WHERE o2.key = 'Closed'
     AND o.order_ts >= '2022-01-01'
     AND o.order_ts < '2023-01-01' ),
     sub_t_cl_ord_2022_fill_null AS
  (SELECT u.id,
          CASE
              WHEN cl_o_22.payment IS NULL THEN 0
              ELSE cl_o_22.payment
          END AS fill_payment
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id),
     sub_t_cl_ord_2022_fill_null_agg AS
  (SELECT sub_t_cl_ord_2022_fill_null.id,
          sum(sub_t_cl_ord_2022_fill_null.fill_payment) AS order_sum
   FROM sub_t_cl_ord_2022_fill_null
   GROUP BY sub_t_cl_ord_2022_fill_null.id),
     test_t AS
  (SELECT id,
          ntile(5) OVER w AS monetary_value
   FROM sub_t_cl_ord_2022_fill_null_agg WINDOW w AS (
                                                     ORDER BY order_sum ASC))
SELECT count(*)
FROM test_t
GROUP BY monetary_value;
*/
-- query for monetary_value metric
INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value) WITH sub_t_cl_ord_2022 AS
  (SELECT *
   FROM analysis.orders o
   LEFT JOIN analysis.orderstatuses o2 ON o.status = o2.id
   WHERE o2.key = 'Closed'
     AND o.order_ts >= '2022-01-01'
     AND o.order_ts < '2023-01-01' ),
                                                                           sub_t_cl_ord_2022_fill_null AS
  (SELECT u.id,
          CASE
              WHEN cl_o_22.payment IS NULL THEN 0
              ELSE cl_o_22.payment
          END AS fill_payment
   FROM analysis.users u
   LEFT JOIN sub_t_cl_ord_2022 cl_o_22 ON u.id = cl_o_22.user_id),
                                                                           sub_t_cl_ord_2022_fill_null_agg AS
  (SELECT sub_t_cl_ord_2022_fill_null.id,
          sum(sub_t_cl_ord_2022_fill_null.fill_payment) AS order_sum
   FROM sub_t_cl_ord_2022_fill_null
   GROUP BY sub_t_cl_ord_2022_fill_null.id)
SELECT id,
       ntile(5) OVER w AS monetary_value
FROM sub_t_cl_ord_2022_fill_null_agg WINDOW w AS (
                                                  ORDER BY order_sum ASC);