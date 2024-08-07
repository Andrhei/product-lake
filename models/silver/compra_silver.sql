{{ config(materialized='view') }}

WITH compra_bronze AS (
    SELECT
        id,
        id_cliente,
        data_vencimento,
        data_pagamento,
        valor,
        categoria,
        moeda,
        CASE 
            WHEN data_pagamento IS NULL
              THEN IF(data_vencimento > CURRENT_DATE(), "PENDENTE", "ATRASO")
            ELSE "PAGO"
        END AS pagamento,
        updated_at
    FROM
        {{ref('compra_bronze')}}
),
cambio_silver AS (
    SELECT
        mes,
        moeda,
        valor
    FROM {{ref('cambio_silver')}}
),
cliente_silver AS (
    SELECT
        id,
        nome,
        nacionalidade
    FROM {{ref('cliente_silver')}}
)
SELECT 
    compra.id,
    cliente.nome AS nome_cliente,
    cliente.nacionalidade AS nacionalidade_cliente,
    compra.data_vencimento,
    compra.data_pagamento,
    compra.moeda,
    compra.valor AS valor_compra,
    cambio.valor AS valor_cambio_referencia,
    compra.valor * cambio.valor AS valor_compra_dolar,
    compra.categoria,
    compra.pagamento AS status_compra,
    compra.updated_at AS data_atualizacao_compra
FROM
    compra_bronze AS compra
    INNER JOIN
    cambio_silver AS cambio
        ON cambio.moeda = compra.moeda
        AND cambio.mes =  FORMAT_DATE("%m", compra.data_vencimento)
    INNER JOIN
    cliente_silver AS cliente
        ON cliente.id = compra.id_cliente
