# Задача — построить витрину для RFM-классификации. Для анализа нужно отобрать только успешно выполненные заказы.
## Требования:
- Витрина должна располагаться в той же базе в схеме analysis.
- Витрина должна состоять из полей:

| Поле | Значения |
|----------|----------|
| user_id | целое число |
| recency | число от 1 до 5 |
| frequency | число от 1 до 5 |
| monetary_value | число от 1 до 5 |

- В витрине нужны данные с начала 2022 года.
- Название витрины dm_rfm_segments.
- Обновления не нужны.
- Успешным считать заказ со статусом Closed
- Количество пользователей в категории должно быть одинаковым

## Анализ данных:
Для расчета фактора recency необходимы поля:
- production.orders.order_ts
- production.orders.user_id
- production.users.id

Для расчета фактора frequency необходимы поля:
- production.orders.order_id
- production.orders.user_id
- production.users.id

Для расчета фактора monetary value необходимы поля:
- production.orders.payment
- production.orders.user_id
- production.users.id

## Замечания:
Необходимо уточнить у заказчика логику использования поля production.orders.bonus_payment.
Как связаны между собой production.orders.bonus_payment и production.orders.payment, а так же фактор monetary value ?


