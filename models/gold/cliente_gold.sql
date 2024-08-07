{{ config(materialized='table') }}

WITH cliente_gold AS (
    SELECT
        id,
        nome,
        nacionalidade
    FROM
        {{ref('cliente_silver')}}
)
SELECT 
    *
FROM cliente_gold
