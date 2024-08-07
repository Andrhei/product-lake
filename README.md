# DBT Project

This DBT (Data Build Tool) project contains a series of models designed for financial and customer data analysis. The models are organized into different layers of granularity, from raw data (`bronze`) to more processed and refined information (`silver` and `gold`).

## Models

### `cambio_bronze`

- **Description**: This table contains historical exchange rate data for various currencies against USD.
- **Columns**:
  - `mes`: The reference month for which the exchange rates are applicable (YYYY-MM).
  - `brl`: The exchange rate from USD to BRL (Brazilian Real).
  - `eur`: The exchange rate from USD to EUR (Euro).
  - `cny`: The exchange rate from USD to CNY (Chinese Yuan).
  - `egp`: The exchange rate from USD to EGP (Egyptian Pound).
  - `kwr`: The exchange rate from USD to KWR (Kuwaiti Dinar).
  - `clp`: The exchange rate from USD to CLP (Chilean Peso).
  - `mxn`: The exchange rate from USD to MXN (Mexican Peso).
  - `updated_at`: Timestamp of the last update to the exchange rate data.

### `cliente_bronze`

- **Description**: This table contains detailed information about customers, including personal and demographic data.
- **Columns**:
  - `id`: Unique identifier for each customer.
  - `nome`: Full name of the customer.
  - `pais`: Country of residence of the customer.
  - `data_nascimento`: Date of birth of the customer.
  - `updated_at`: Timestamp of the last update to the customer record.

### `compra_bronze`

- **Description**: This table contains detailed information about purchases made by clients.
- **Columns**:
  - `id`: Unique identifier for each purchase.
  - `id_cliente`: Unique identifier for the client associated with the purchase.
  - `data_vencimento`: Due date for the payment of the purchase.
  - `data_pagamento`: Date when the payment was made.
  - `valor`: Total amount of the purchase.
  - `categoria`: Category of the purchase.
  - `moeda`: Currency used in the purchase.
  - `status`: Current status of the purchase (e.g., "PENDENTE", "ATRASO", "PAGO").
  - `updated_at`: Timestamp of the last update to the purchase record.

### `cambio_silver`

- **Description**: This table contains detailed information about currency exchange rates.
- **Columns**:
  - `mes`: The month for which the exchange rate is applicable.
  - `valor`: The exchange rate value.
  - `moeda`: Currency code (e.g., BRL, EUR).

### `cliente_silver`

- **Description**: Table containing detailed client information.
- **Columns**:
  - `id`: Unique identifier for the client.
  - `nome`: Client name.
  - `nacionalidade`: Client nationality.

### `compra_silver`

- **Description**: Table containing detailed purchase information.
- **Columns**:
  - `nome_cliente`: Name of the client.
  - `nacionalidade_cliente`: Nationality of the client.
  - `data_vencimento`: Due date for the payment.
  - `data_pagamento`: Actual payment date.
  - `valor_compra`: Total purchase amount.
  - `valor_cambio_referencia`: Reference exchange rate value.
  - `valor_compra_dolar`: Purchase amount in dollars.
  - `categoria`: Category of the purchase.
  - `moeda`: Currency used in the purchase.
  - `status_compra`: Current status of the purchase (e.g., "PENDENTE", "ATRASO", "PAGO").
  - `data_atualizacao_compra`: Timestamp of the last purchase update.

### `cliente_gold`

- **Description**: Table containing detailed client information.
- **Columns**:
  - `id`: Unique identifier for the client.
  - `nome`: Client name.
  - `nacionalidade`: Client nationality.

### `compra_gold`

- **Description**: Table containing detailed purchase information.
- **Columns**:
  - `nome_cliente`: Name of the client.
  - `nacionalidade_cliente`: Nationality of the client.
  - `data_vencimento`: Due date for the payment.
  - `data_pagamento`: Actual payment date.
  - `valor_compra`: Total purchase amount.
  - `valor_cambio_referencia`: Reference exchange rate value.
  - `valor_compra_dolar`: Purchase amount in dollars.
  - `categoria`: Category of the purchase.
  - `moeda`: Currency used in the purchase.
  - `status_compra`: Current status of the purchase (e.g., "PENDENTE", "ATRASO", "PAGO").
  - `data_atualizacao_compra`: Timestamp of the last purchase update.

