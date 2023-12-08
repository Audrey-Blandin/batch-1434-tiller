with table_agg as (
    SELECT
        id_store,
        id_waiter,
        FORMAT_DATE('%Y-%m-%d', date_opened) as date_date,
        extract(HOUR FROM date_opened) as hour,
        COUNT(id_order) as nb_orders,
        round(SUM(m_cached_payed),2) as turnover,
        round(SUM(pourboire),2) as pourboire,
        round(SUM(solde_caisse_debiteur),2) as solde_caisse_debiteur,
        SUM(m_nb_customer) as total_customers,
        round((SUM(m_nb_customer)/COUNT(id_table)),1) as avg_client_per_table,
        ROUND(AVG(minutes_on_a_table),2) as avg_time_on_table_min
FROM {{ref("int_global_performance")}}
GROUP BY 1,2,3,4),

add_service as(
    SELECT
        t.*,
        s.service
    FROM table_agg as t
    LEFT JOIN {{ref("stg_tiller__type_service")}} as s
    ON t.hour=s.hour
)

SELECT
adds.*,
v.vacances_oui_non,
v.type_vacances,
v.type_jour_ferie,
v.jours_feries_oui_non,
v.saison
FROM add_service as adds
LEFT JOIN {{ref('stg_tiller__vacances_feries_saison_zonec_2018_2020')}} as v
ON adds.date_date=v.dates

