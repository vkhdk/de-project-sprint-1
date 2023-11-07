-- query for test
/*
WITH sub_t AS
  (SELECT u.id,
          sum(o.payment) AS order_sum
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
     sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN order_sum IS NULL THEN 0
              ELSE order_sum
          END
   FROM sub_t),
     monetary_value_sub_t_fill_nulls AS
  (SELECT ntile(5) OVER w AS monetary_value,
                        id,
                        order_sum
   FROM sub_t_fill_nulls WINDOW w AS (
                                      ORDER BY order_sum ASC)
   ORDER BY monetary_value ASC)
SELECT count(*)
FROM monetary_value_sub_t_fill_nulls
GROUP BY monetary_value;
*/
-- query for monetary_value metric
INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value) WITH sub_t AS
  (SELECT u.id,
          sum(o.payment) AS order_sum
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
                                                                           sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN order_sum IS NULL THEN 0
              ELSE order_sum
          END
   FROM sub_t)
SELECT id,
       ntile(5) OVER w AS monetary_value
FROM sub_t_fill_nulls WINDOW w AS (
                                   ORDER BY order_sum ASC)
ORDER BY monetary_value ASC;