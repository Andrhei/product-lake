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

## Data Quality

### Data Quality Tests

To ensure the integrity and accuracy of the data in the DBT project models, we implemented a series of data quality tests. These tests are essential for identifying and correcting issues that could compromise analyses and decisions based on this data.

#### 1. Duplicate Testing

Duplicates in data can lead to incorrect analyses and misleading results. To avoid this, we perform duplicate tests on several critical tables in the project.

- **cliente_bronze**: We test for duplicates in the `id` column, which should be unique for each customer.
- **compra_bronze**: We test for duplicates in the `id` column, which should be unique for each purchase.

#### 2. Date Format Testing

Incorrect date formats can cause failures in data transformations and analyses. We verify that the date columns are in the expected format.

- **cliente_bronze**: The `data_nascimento` column should be in the `YYYY-MM-DD` format.
- **compra_bronze**: The `data_vencimento` and `data_pagamento` columns should be in the `YYYY-MM-DD` format.

#### 3. Not Null Column Testing

Columns that cannot contain null values are critical to maintaining data integrity. We ensure these columns contain valid values in all rows.

- **cliente_bronze**: The `id`, `nome`, `pais`, `data_nascimento`, and `updated_at` columns cannot contain null values.
- **compra_bronze**: The `id`, `id_cliente`, `data_vencimento`, `valor`, `categoria`, `moeda`, `status`, and `updated_at` columns cannot contain null values.

#### 4. Accepted Values Testing

Some columns must contain only values within a specific set of options. We check that the values in these columns are valid.

- **compra_bronze**: The `status` column should contain only the values "PENDING", "LATE", or "PAID".
