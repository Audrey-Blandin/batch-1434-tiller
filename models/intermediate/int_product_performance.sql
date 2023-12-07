select
    order_data.id_store,
    order_data.id_order,
    order_data.date_opened,
    order_line.id_order_line,
    order_line.dim_type,
    order_line.dim_category,
    order_line.dim_name,
    order_line.dim_feature_type,
    order_line.m_quantity,
    order_line.m_unit_price,
    order_line.m_total_price_inc_vat
FROM {{ref("stg_tiller__order_data")}} order_data
LEFT JOIN {{ref("stg_tiller__order_line")}} order_line
USING (id_order)