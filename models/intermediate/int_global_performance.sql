select
    id_store,
    id_order,
    id_table,
    id_waiter,
    date_opened,
    date_closed,
    date_diff(date_closed, date_opened, MINUTE) as minutes_on_a_table,
    m_nb_customer,
    m_cached_payed,
    m_cached_price,
    round(m_cached_payed-m_cached_price,2) as solde_payed_price,
    CASE
        WHEN m_cached_payed-m_cached_price<0 THEN round(m_cached_payed-m_cached_price,2)
        ELSE 0
        END AS solde_caisse_debiteur,
    CASE
        WHEN m_cached_payed-m_cached_price>0 THEN round(m_cached_payed-m_cached_price,2)
        ELSE 0
        END AS pourboire    
FROM {{ref("stg_tiller__order_data")}} order_data
