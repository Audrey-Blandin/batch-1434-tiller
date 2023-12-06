with 

product_performance as (

SELECT
  id_store,
  date_opened,
  extract(HOUR FROM date_opened) as hour,
  dim_type,
  dim_category,
  dim_name,
  dim_feature_type,
  round(sum(m_quantity),0) as m_quantity,
  round(avg(m_unit_price),2) as avg_unit_price,
  round(sum(m_total_price_inc_vat),2) as m_total_price_inc_vat
FROM {{ref("int_product_performance")}} 
GROUP BY 1,2,3,4,5,6,7)

SELECT
  product_performance.id_store,
  product_performance.date_opened,
  product_performance.hour,
  type_service.service,
  product_performance.dim_type,
  product_performance.dim_category,
  product_performance.dim_name,
  product_performance.dim_feature_type,
  product_performance.m_quantity,
  product_performance.avg_unit_price,
  product_performance.m_total_price_inc_vat
FROM product_performance
LEFT JOIN {{ref("stg_tiller__type_service")}} type_service
USING (hour)