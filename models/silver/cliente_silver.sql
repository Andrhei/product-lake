{{ config(materialized='view') }}

WITH cliente_silver AS (
    SELECT
        id,
        nome,
        pais AS nacionalidade
    FROM
        {{ref('cliente_bronze')}}
)
SELECT 
    *
FROM cliente_silver
ORDER BY id ASC