# Анализ качества данных
## Инструменты для обеспечения качества данных:
### Ограничения:

| Таблица | Название | Тип | Выражение | Комментарий |
|----------|----------|----------|----------|----------|
| orderitems | orderitems_check | CHECK | (((discount >= (0)::numeric) AND (discount <= price))) | Ограничение по значению поля |
| orderitems | orderitems_order_id_product_id_key | UNIQUE KEY | - | Уникальность хначений в полях order_id и product_id |