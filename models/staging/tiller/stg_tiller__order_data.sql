with 

source as (

    select * from {{ source('tiller', 'order_data') }}

),

renamed as (

    select
        id_order,
        id_store,
        id_table,
        id_waiter,
        id_device,
        date_opened,
        date_closed,
        dim_status,
        dim_source,
        m_nb_customer,
        m_cached_payed,
        m_cached_price

    from source

)

select * from renamed
