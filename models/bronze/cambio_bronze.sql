{{ config(materialized='table') }}

WITH cambio_bronze AS (

    SELECT
        `Mês` AS mes,
        CAST(REPLACE(`BRL`, ",", ".") AS NUMERIC) AS brl,
        CAST(REPLACE(`EUR`, ",", ".") AS NUMERIC) AS eur,
        CAST(REPLACE(`CNY`, ",", ".") AS NUMERIC) AS cny,
        CAST(REPLACE(`EGP`, ",", ".") AS NUMERIC) AS egp,
        CAST(REPLACE(`KRW`, ",", ".") AS NUMERIC) AS kwr,
        CAST(REPLACE(`CLP`, ",", ".") AS NUMERIC) AS clp,
        CAST(REPLACE(`MXN`, ",", ".") AS NUMERIC) AS mxn,
        `updated_at`
    FROM {{ ref('cambio') }}

)

SELECT *
FROM cambio_bronze