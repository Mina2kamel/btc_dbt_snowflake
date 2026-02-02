WITH whales AS (
    SELECT
        output_address,
        SUM(output_value) AS total_received,
        COUNT(*) AS transaction_count
    FROM {{ ref('int_btc_transactions') }}
    WHERE output_value >= 10
    GROUP BY output_address
    order BY total_received DESC
)
SELECT 
    output_address,
    total_received,
    transaction_count,
    {{ convert_to_usd('total_received') }} AS total_received_usd
FROM whales
ORDER BY total_received DESC