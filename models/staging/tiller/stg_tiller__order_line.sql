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
        translate (REGEXP_REPLACE(lower(dim_category),"ƒ", ""), "ŠŽšžŸÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðñòóôõöùúûüýÿ", "SZszYAAAAAACEEEEIIIIDNOOOOOUUUUYaaaaaaceeeeiiiidnooooouuuuyy") as dim_category,
        translate(lower(dim_name), "ŠŽšžŸÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖÙÚÛÜÝàáâãäåçèéêëìíîïðñòóôõöùúûüýÿ", "SZszYAAAAAACEEEEIIIIDNOOOOOUUUUYaaaaaaceeeeiiiidnooooouuuuyy") as dim_name,
        dim_status,
        CASE WHEN dim_feature_type IS NULL THEN "Other" ELSE dim_feature_type END as dim_feature_type,
        CASE WHEN dim_unit_measure IS NULL THEN "Not defined" ELSE dim_unit_measure END as dim_unit_measure,
        CASE WHEN dim_unit_measure_display IS NULL THEN "Not defined" ELSE dim_unit_measure_display END as dim_unit_measure_display,
        dim_category_translated,
        dim_name_translated

    from source

)

select * from renamed
