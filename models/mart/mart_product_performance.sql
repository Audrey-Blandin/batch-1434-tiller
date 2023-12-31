with 

product_performance as (

SELECT
  id_store,
  FORMAT_DATE('%Y-%m-%d', date_opened) as date_date,
  extract(HOUR FROM date_opened) as hour,
  dim_type,
  dim_category,
  dim_name,
  dim_feature_type,
  round(sum(m_quantity),0) as m_quantity,
  round(avg(m_unit_price),2) as avg_unit_price,
  round(sum(m_total_price_inc_vat),2) as m_total_price_inc_vat,
  count(id_order) as nb_orders
FROM {{ref("int_product_performance")}} 
GROUP BY 1,2,3,4,5,6,7),

prodperfserv as(
SELECT
  product_performance.id_store,
  product_performance.date_date,
  product_performance.hour,
  type_service.service,
  product_performance.dim_type,
  product_performance.dim_category,
  product_performance.dim_name,
  product_performance.dim_feature_type,
  product_performance.m_quantity,
  product_performance.avg_unit_price,
  product_performance.m_total_price_inc_vat,
  product_performance.nb_orders
FROM product_performance
LEFT JOIN {{ref("stg_tiller__type_service")}} type_service
USING (hour)
)



SELECT
p.*,
v.vacances_oui_non,
v.type_vacances,
v.type_jour_ferie,
v.jours_feries_oui_non,
v.saison
FROM prodperfserv as p
LEFT JOIN {{ref('stg_tiller__vacances_feries_saison_zonec_2018_2020')}} as v
ON p.date_date=v.dates