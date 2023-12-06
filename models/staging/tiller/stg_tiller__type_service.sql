with 

source as (

    select * from {{ source('tiller', 'type_service') }}

),

renamed as (

    select
        hour,
        service

    from source

)

select * from renamed
