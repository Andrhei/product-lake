{{ config(materialized='view') }}

WITH compra_bronze AS (

    SELECT
        `id`,
        `id_cliente`,
        CAST(
            FORMAT_DATE('%Y-%m-%d',
                COALESCE(
                SAFE.PARSE_DATE('%d/%m/%Y', `data_vencimento`),
                SAFE.PARSE_DATE('%Y-%m-%d', `data_vencimento`),
                SAFE.PARSE_DATE('%m/%d/%Y', `data_vencimento`) 
                )
            )  AS DATE
        ) AS data_vencimento,
        CAST(
            FORMAT_DATE('%Y-%m-%d',
                COALESCE(
                SAFE.PARSE_DATE('%d/%m/%Y', `data_pagamento`),
                SAFE.PARSE_DATE('%Y-%m-%d', `data_pagamento`),
                SAFE.PARSE_DATE('%m/%d/%Y', `data_pagamento`) 
                )
            )  AS DATE
        ) AS data_pagamento,
        CAST(REPLACE(`valor`, ",", ".") AS NUMERIC) AS valor,
        `categoria`,
        `moeda`,
        `status`,
        `updated_at`,
        ROW_NUMBER() OVER(PARTITION BY `id` ORDER BY `updated_at` DESC) AS rk
    FROM {{ ref('compra') }}
)

SELECT
    id,
    id_cliente,
    data_vencimento,
    data_pagamento,
    valor,
    categoria,
    moeda,
    status,
    updated_at
FROM compra_bronze
WHERE rk = 1