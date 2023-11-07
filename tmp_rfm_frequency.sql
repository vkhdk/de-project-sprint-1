-- query for test
/*
WITH sub_t AS
  (SELECT u.id,
          count(o.order_id) AS order_count
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
     sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN order_count IS NULL THEN 0
              ELSE order_count
          END
   FROM sub_t),
     frequency_sub_t_fill_nulls AS
  (SELECT ntile(5) OVER w AS frequency,
                        id,
                        order_count
   FROM sub_t_fill_nulls WINDOW w AS (
                                      ORDER BY order_count ASC)
   ORDER BY order_count ASC)
SELECT count(*)
FROM frequency_sub_t_fill_nulls
GROUP BY frequency;
*/
-- query for frequency metric
INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency) WITH sub_t AS
  (SELECT u.id,
          count(o.order_id) AS order_count
   FROM analysis.users u
   LEFT JOIN analysis.orders o ON u.id = o.user_id
   GROUP BY u.id),
                                                                 sub_t_fill_nulls AS
  (SELECT id,
          CASE
              WHEN order_count IS NULL THEN 0
              ELSE order_count
          END
   FROM sub_t)
SELECT id,
       ntile(5) OVER w AS frequency
FROM sub_t_fill_nulls WINDOW w AS (
                                   ORDER BY order_count ASC)
ORDER BY order_count ASC;