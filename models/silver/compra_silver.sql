{{ config(materialized='table') }}

WITH compra_silver AS (
    SELECT
        id_cliente,
        data_vencimento,
        data_pagamento,
        valor,
        categoria,
        moeda,
        status,
        CASE 
            WHEN data_pagamento IS NULL
              THEN IF(data_vencimento > CURRENT_DATE(), "PENDENTE", "ATRASO")
            ELSE "PAGO"
        END AS pagamento
    FROM
        {{ref('compra_bronze')}}
)
SELECT 
    *
FROM compra_silver