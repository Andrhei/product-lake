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

SELECT
    CASE mes
        WHEN "Janeiro" THEN "01"
        WHEN "Fevereiro" THEN "02"
        WHEN "Março" THEN "03"
        WHEN "Abril" THEN "04"
        WHEN "Maio" THEN "05"
        WHEN "Junho" THEN "06"
        WHEN "Julho" THEN "07"
        WHEN "Agosto" THEN "08"
        WHEN "Setembro" THEN "09"
        WHEN "Outubro" THEN "10"
        WHEN "Novembro" THEN "11"
        WHEN "Dezembro" THEN "12"
        ELSE NULL
    END AS mes,
    brl,
    eur,
    cny,
    egp,
    kwr,
    clp,
    mxn,
    updated_at
FROM cambio_bronze