{{ config(materialized='view') }}

WITH cambio_silver AS (
    SELECT
        mes,
        valor,
        moeda
    FROM
        {{ref('cambio_bronze')}}
    UNPIVOT ( valor FOR moeda IN ( brl, eur, cny, egp, kwr, clp, mxn ) )
)
SELECT 
    mes,
    valor,
    UPPER(moeda) AS moeda
FROM cambio_silver