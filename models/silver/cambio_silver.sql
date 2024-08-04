{{ config(materialized='table') }}

WITH cambio_silver AS (
    SELECT
        mes,
        valor,
        moeda
    FROM
        {{ref('cambio_bronze')}}
    UNPIVOT ( valor FOR moeda IN ( brl, eur, cny, egp, kwr, clp, mxn ) )
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
    valor,
    UPPER(moeda) AS moeda
FROM cambio_silver