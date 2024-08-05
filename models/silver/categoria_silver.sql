{{ config(materialized='table') }}

WITH categoria_silver AS (
    SELECT DISTINCT
        categoria
    FROM
        {{ref('compra_bronze')}}
)
SELECT
    *
FROM categoria_silver