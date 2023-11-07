-- analysis.dm_rfm_segments definition

-- Drop table

-- DROP TABLE analysis.dm_rfm_segments;

CREATE TABLE analysis.dm_rfm_segments (
	user_id int4 NOT NULL,
	recency int2 NOT NULL,
	frequency int2 NOT NULL,
	monetary_value int2 NOT NULL,
	CONSTRAINT frequency_check CHECK ((((frequency)::numeric >= (1)::numeric) AND ((frequency)::numeric <= (5)::numeric))),
	CONSTRAINT monetary_value_check CHECK ((((monetary_value)::numeric >= (1)::numeric) AND ((monetary_value)::numeric <= (5)::numeric))),
	CONSTRAINT recency_check CHECK ((((recency)::numeric >= (1)::numeric) AND ((recency)::numeric <= (5)::numeric))),
	CONSTRAINT user_id_pkey PRIMARY KEY (user_id)
);

-- При join по user_id возможны ситуации когда у пользователя нет одного из факторов ?
-- Является ли это ошибкой ?
-- Да, является. Должен использоваться один набор user_id для расчета всех факторов. Поэтому необходимо ограничение NOT NULL

-- intermediate tables for factors
CREATE TABLE analysis.tmp_rfm_recency (
 user_id INT NOT NULL PRIMARY KEY,
 recency INT NOT NULL CHECK(recency >= 1 AND recency <= 5)
);
CREATE TABLE analysis.tmp_rfm_frequency (
 user_id INT NOT NULL PRIMARY KEY,
 frequency INT NOT NULL CHECK(frequency >= 1 AND frequency <= 5)
);
CREATE TABLE analysis.tmp_rfm_monetary_value (
 user_id INT NOT NULL PRIMARY KEY,
 monetary_value INT NOT NULL CHECK(monetary_value >= 1 AND monetary_value <= 5)
);