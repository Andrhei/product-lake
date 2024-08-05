{{ config(materialized='table') }}

WITH rank_cliente AS (
    SELECT
        cliente.nome AS cliente,
        cliente.nacionalidade,
        compra.valor * cambio.valor AS valor_dolar
    FROM
        {{ref('compra_silver')}} AS compra
        INNER JOIN
        {{ref('cliente_silver')}} AS cliente
            ON cliente.id = compra.id_cliente
        INNER JOIN
        {{ref('cambio_silver')}} AS cambio
            ON cambio.mes = FORMAT_DATE("%m", compra.data_vencimento)
            AND compra.moeda = cambio.moeda
)
SELECT
    *
FROM rank_cliente
ORDER BY valor_dolar DESC