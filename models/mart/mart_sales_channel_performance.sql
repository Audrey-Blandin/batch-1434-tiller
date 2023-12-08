SELECT
adds.*,
v.vacances_oui_non,
v.type_vacances,
v.type_jour_ferie,
v.jours_feries_oui_non,
v.saison
FROM {{ ref('int_sales_channel_performance') }} as adds
LEFT JOIN {{ref('stg_tiller__vacances_feries_saison_zonec_2018_2020')}} as v
ON adds.date_date=v.dates