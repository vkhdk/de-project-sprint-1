# Анализ качества данных
## Инструменты для обеспечения качества данных:
### Ограничения:

| Таблица | Название | Тип | Выражение | Комментарий |
|----------|----------|----------|----------|----------|
| orderitems | orderitems_check | CHECK | (((discount >= (0)::numeric) AND (discount <= price))) | Ограничение по значению поля discount |
| orderitems | orderitems_order_id_product_id_key | UNIQUE KEY | - | Уникальность значений в полях order_id и product_id |
| orderitems | orderitems_pkey | PRIMARY KEY | - | Уникальность значений в поле id |
| orderitems | orderitems_price_check | CHECK | ((price >= (0)::numeric)) | Ограничение по значению поля price |
| orderitems | orderitems_quantity_check | CHECK | ((quantity > 0)) | Ограничение по значению поля quantity |
| orders | orders_check | CHECK | ((quantity > 0)) | ((cost = (payment + bonus_payment))) |  Ограничение по значению поля cost |
| orders | orders_pkey | PRIMARY KEY | - | Уникальность значений в поле order_id |
| orderstatuses | orderstatuses_pkey | PRIMARY KEY | - | Уникальность значений в поле id |
| orderstatuslog | orderstatuslog_order_id_status_id_key | UNIQUE KEY | - | никальность значений в полях order_id и status_id |
| orderstatuslog | orderstatuslog_pkey | PRIMARY KEY | - | Уникальность значений в поле id |
| products | products_pkey | PRIMARY KEY | - | Уникальность значений в поле id |
| products | products_price_check | CHECK | ((price >= (0)::numeric)) | Ограничение по значению поля price |
| users | users_pkey | PRIMARY KEY | - | Уникальность значений в поле id |

#### Вывод:
- В каждой таблице присуствует ограничение по первичному ключу.
- Для некоторых полей задано ограничение обусловленное их свойствами. Например цена(price) не может быть меньше нуля

### Заданные типы данных:

| Имя поля | Таблица | Тип данных | Автоувеличение | Not Null | По умолчанию |
|----------|----------|----------|----------|----------|----------|
|id | orderitems | int4 | Always | true | [NULL] |
| product_id | orderitems | int4 | [NULL] | true | [NULL] |
| order_id | orderitems | int4 | [NULL] | true | [NULL] |
|name|orderitems | varchar(2048) | [NULL] | true | [NULL] |
| price | orderitems | numeric(19, 5) | [NULL] | true | 0 |
| discount | orderitems | numeric(19, 5) | [NULL] | true | 0 |
| quantity | orderitems | int4 | [NULL] | true | [NULL] |
| order_id | orders | int4 | [NULL] | true | [NULL] |
| order_ts | orders | timestamp | [NULL] | true | [NULL] |
| user_id | orders | int4 | [NULL] | true | [NULL] |
| bonus_payment | orders | numeric(19, 5) | [NULL] | true | 0 |
| payment | orders | numeric(19, 5) | [NULL] | true | 0 |
| cost | orders | numeric(19, 5) | [NULL] | true | 0 |
| bonus_grant | orders | numeric(19, 5) | [NULL] | true | 0 |
| status | orders | int4 | [NULL] | true | [NULL] |
| id | orderstatuses | int4 | [NULL] | true | [NULL] |
| key | orderstatuses | varchar(255) | [NULL] | true | [NULL] |
| id | orderstatuslog | int4 | Always | true | [NULL] |
| order_id | orderstatuslog | int4 | [NULL] | true | [NULL] |
| status_id | orderstatuslog | int4 | [NULL] | true | [NULL] |
| dttm | orderstatuslog | timestamp | [NULL] | true | [NULL] |
| id | products | int4 | [NULL] | true | [NULL] |
| name | products | varchar(2048) | [NULL] | true | [NULL] |
| price | products | numeric(19, 5) | [NULL] | true | 0 |
| id | users | int4 | [NULL] | true | [NULL] |
| name | users | varchar(2048) | [NULL] | false | [NULL] |
| login | users | varchar(2048) | [NULL] | true | [NULL] |

#### Вывод:
- Типы данных указаны корректно
- В таблице users допускается отсуствие значений в поле name
- Все числовые поля имеют занчение по умолчанию - ноль

# Вывод:
- Нет замечаний к качеству исходных данных
