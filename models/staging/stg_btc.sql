{{ config(
    materialized='incremental', 
    incremental_strategy='merge', 
    unique_key='hash_key') 
}}

SELECT 
* 
FROM {{source('btc_transactions', 'btc_transactions')}} 

{% if is_incremental() %}
    WHERE block_timestamp > (SELECT MAX(block_timestamp) FROM {{ this }})
{% endif %}