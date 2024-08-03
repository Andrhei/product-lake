{{ config(materialized='table') }}

WITH cambio_bronze AS (

    SELECT
        *
    FROM {{ ref('cambio') }}

)

SELECT *
FROM cambio_bronze