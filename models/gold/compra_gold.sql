{{ config(
    materialized='incremental',
    unique_key='id'
) }}

WITH compra_gold AS (
    SELECT
        id,
        nome_cliente,
        nacionalidade_cliente,
        data_vencimento,
        data_pagamento,
        valor_compra,
        valor_cambio_referencia,
        valor_compra_dolar,
        categoria,
        moeda,
        status_compra,
        data_atualizacao_compra
    FROM {{ref('compra_silver')}}
)
SELECT * FROM compra_gold


{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
where data_atualizacao_compra >= (select coalesce(max(data_atualizacao_compra),'1900-01-01') from {{ this }} )

{% endif %}