with 

source as (

    select * from {{ source('tiller', 'vacances_feries_saison_zonec_2018_2020') }}

),

renamed as (

    select
        dates,
        vacances__scolaires_non_scolaires as vacances_oui_non,
        type_vacances_oui_non as type_vacances,
        jours_feries_fete as type_jour_ferie,
        jours_feries_oui_non,
        saison

    from source

)

select * from renamed
