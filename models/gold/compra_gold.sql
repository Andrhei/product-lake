{{ config(materialized='table') }}

WITH compra_gold AS (
    SELECT
        nome_cliente,
        nacionalidade_cliente,
        data_vencimento,
        data_pagamento,
        valor_compra,
        valor_cambio_referencia,
        valor_compra_dolar,
        categoria,
        moeda,
        status_compra,
        data_atualizacao_compra
    FROM {{ref('compra_silver')}}
)
SELECT * FROM compra_gold