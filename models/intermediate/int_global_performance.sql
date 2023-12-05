select
    id_store,
    id_order,
    id_table,
    id_waiter,
    date_opened,
    date_closed,
    date_diff(date_closed, date_opened, MINUTE) as minutes_on_a_table,
    m_nb_customer,
    m_cached_payed
FROM {{ref("stg_tiller__order_data")}} order_data
