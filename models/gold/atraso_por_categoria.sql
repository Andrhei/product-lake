{{ config(materialized='table') }}

WITH atraso_por_categoria AS (
    SELECT
        compra.categoria,
        COUNT(compra.categoria) AS quantidade
    FROM
        {{ref('compra_silver')}} AS compra
    WHERE
        compra.pagamento = "ATRASO"
    GROUP BY compra.categoria
)
SELECT
    *
FROM atraso_por_categoria
ORDER BY quantidade DESC