
WITH adding_store AS (
  SELECT
    p.*,
    o.id_store,
     CASE
      WHEN p.dim_type = 'DELIVEROO' THEN 'Deliveroo'
      WHEN p.dim_type = 'ALLORESTO' THEN 'AlloResto'
      WHEN p.dim_type = 'UBER EATS' THEN 'UberEats'
      WHEN p.dim_type IN ('CB_Sans_Contact','CARD', 'CB_SANS_CONTACT', 'CB_sans_contact','AMERICAN_EXPRESS') THEN 'Carte_Bleue'
      WHEN p.dim_type IN ('CARTE CADEAU') THEN 'Carte_Cadeau'
      WHEN p.dim_type IN ('BANK_TRANSFER', 'BANK_CHECK') THEN 'Transfert_Bancaire'
      WHEN p.dim_type IN ('VOUCHER', 'CARTE_TICKET_RESTAURANT', 'CARTE TICKET RESTAURANT','TICKET_RESTAURANT', 'Ticket_Restaurant_carte', 'CB_TICKET_RESTO', 'RESTO_FLASH') THEN 'Ticket_Restaurant'
      WHEN p.dim_type IN ('SUMUP', 'SIOUPLAIT', 'TAB', 'POURBOIRE_CARTE_BLEUE', 'FIVORY','AUTRES', 'alipay', 'ARRHES','APPLE PAY') THEN 'Autres_payments_electroniques'
      WHEN p.dim_type IN ( 'CREDIT_NOTE') THEN 'Credit'
      WHEN p.dim_type IN ('CLICKEAT') THEN 'Click_and_Collect'
      WHEN p.dim_type IN ('LIVRAISON') THEN 'Livraison'
      WHEN p.dim_type IN ('avoir_encaissé', 'AVOIR_ENCAISSÉ') THEN 'Avoir_Encaissé'
      WHEN p.dim_type IN ('CASH') THEN 'Cash'
      ELSE 'Unknown'
    END AS dim_type_clean,
  FROM {{ref("stg_tiller__payment_data")}} AS p 
  LEFT JOIN {{ref("stg_tiller__order_data")}} AS o
  ON p.id_order = o.id_order
),
column_creating as (
  select *,
 CASE
      WHEN dim_type_clean IN ('Click_and_Collect','Livraison', 'Deliveroo', 'AlloResto', 'UberEats') THEN 'Ventes_à_emporter'
      ELSE 'Ventes_sur_place'
    END AS sales_channel,
    FROM adding_store
),
agg_table AS (
  SELECT
    FORMAT_DATE('%F', date_created) AS date_date,
    id_store,
    ROUND(SUM(m_amount), 2) AS turnover,
    COUNT(id_pay) AS nb_of_payment,
    sales_channel,
    dim_type_clean,
  FROM column_creating 
  GROUP BY date_date, id_store, dim_type, sales_channel, dim_type_clean
)

SELECT * FROM agg_table