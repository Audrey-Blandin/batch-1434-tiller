with adding_store as (
  SELECT
    p.*,
    o.id_store
FROM {{ref("stg_tiller__payment_data")}} as p 
LEFT JOIN {{ref("stg_tiller__order_data")}} as o
ON p.id_order=o.id_order
),

agg_table as(
  SELECT
    FORMAT_DATE('%F',date_created) as date_date,
    id_store,
    dim_type,
    ROUND(SUM(m_amount),2) as turnover
  FROM adding_store 
  GROUP BY date_date,id_store,dim_type
)

SELECT * FROM agg_table