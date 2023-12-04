with 

source as (

    select * from {{ source('tiller', 'order_line') }}

),

renamed as (

    select
        id_order_line,
        id_order,
        date_opended,
        date_created,
        m_quantity,
        m_unit_price,
        m_unit_price_exc_vat,
        m_total_price_inc_vat,
        m_total_price_exc_vat,
        m_tax_percent,
        m_discount_amount,
        dim_type,
        dim_category,
        dim_name,
        dim_status,
        dim_feature_type,
        dim_unit_measure,
        dim_unit_measure_display,
        dim_category_translated,
        dim_name_translated

    from source

)

select * from renamed
