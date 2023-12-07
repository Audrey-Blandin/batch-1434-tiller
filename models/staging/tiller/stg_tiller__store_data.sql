with 

source as (

    select * from {{ source('tiller', 'store_data') }}

),

renamed as (

    select
        id_store,
        date_created,
        dim_zipcode,
        dim_country,
        dim_currency

    from source
    where id_store<>7786 and id_store<>6008

)

select * from renamed
