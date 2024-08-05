{{ config(materialized='table') }}

WITH compra_silver AS (
    SELECT
        id_cliente,
        data_vencimento,
        data_pagamento,
        valor,
        categoria,
        moeda,
        status
    FROM
        {{ref('compra_bronze')}}
)
SELECT 
    *
FROM compra_silver