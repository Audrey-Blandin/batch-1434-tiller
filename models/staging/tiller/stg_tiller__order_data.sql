with 

source as (

    select * from {{ source('tiller', 'order_data') }}

),

renamed as (

    select
        id_order,
        id_store,
        CASE WHEN id_table IS NULL THEN 0 ELSE id_table END AS id_table,
        CASE WHEN id_waiter IS NULL THEN 0 ELSE id_waiter END AS id_waiter,
        CASE WHEN id_device IS NULL THEN 0 ELSE id_device END AS id_device,
        date_opened,
        date_closed,
        dim_status,
        CASE WHEN dim_source IS NULL THEN 'Other' ELSE dim_source END AS dim_source,
        CASE WHEN m_nb_customer=0 THEN 1 ELSE m_nb_customer END AS m_nb_customer,
        m_cached_payed,
        m_cached_price

    from source
    where id_store<>7786 and id_store<>6008

)

select * from renamed
