with table_agg as (
    SELECT
        id_store,
        FORMAT_DATE('%Y-%m-%d', date_opened) as date_date,
        extract(HOUR FROM date_opened) as hour,
        COUNT(id_order) as nb_orders,
        SUM(m_cached_payed) as turnover,
        SUM(m_nb_customer) as total_customers,
        (SUM(m_nb_customer)/COUNT(id_table)) as avg_client_per_table,
        ROUND(AVG(minutes_on_a_table),2) as avg_time_on_table_min
FROM {{ref("int_global_performance")}}
GROUP BY 1,2,3),

add_service as(
    SELECT
        t.*,
        s.service
    FROM table_agg as t
    LEFT JOIN {{ref("stg_tiller__type_service")}} as s
    ON t.hour=s.hour
)

SELECT * FROM add_service