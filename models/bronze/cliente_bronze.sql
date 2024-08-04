{{ config(materialized='table') }}

WITH cliente_bronze AS (

    SELECT
        `id`,
        `name` AS nome,
        `pais`,
        CAST(
            FORMAT_DATE('%Y-%m-%d',
                COALESCE(
                SAFE.PARSE_DATE('%d/%m/%Y', `data nascimento`),
                SAFE.PARSE_DATE('%Y-%m-%d', `data nascimento`),
                SAFE.PARSE_DATE('%m/%d/%Y', `data nascimento`) 
                )
            )  AS DATE
        ) AS data_nascimento,
        `updated_at`,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY updated_at DESC) AS rk
    FROM {{ ref('cliente') }}

)

SELECT
    id,
    nome,
    pais,
    data_nascimento,
    updated_at
FROM cliente_bronze
WHERE rk = 1