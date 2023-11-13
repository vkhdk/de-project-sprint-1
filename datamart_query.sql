INSERT INTO analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
SELECT trf.user_id ,
       trr.recency,
       trf.frequency,
       trmv.monetary_value
FROM analysis.tmp_rfm_frequency trf
LEFT JOIN analysis.tmp_rfm_monetary_value trmv ON trf.user_id = trmv.user_id
LEFT JOIN analysis.tmp_rfm_recency trr ON trf.user_id = trr.user_id;

0	1	3	4
1	4	3	3
2	2	3	5
3	2	3	3
4	4	3	3
5	5	5	5
6	1	3	5
7	4	2	2
8	1	2	3
9	1	2	2