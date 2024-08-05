{{ config(materialized='table') }}

WITH cambio_silver AS (
    SELECT
        id,
        nome,
        pais AS nacionalidade
    FROM
        {{ref('cliente_bronze')}}
)
SELECT 
    *
FROM cambio_silver
ORDER BY id ASC