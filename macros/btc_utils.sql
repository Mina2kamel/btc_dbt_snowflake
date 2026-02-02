{% macro convert_to_usd(col) %}
    {{ col }} * (
        SELECT price
        FROM {{ ref('btc_usd_max') }}
        WHERE TO_DATE(REPLACE(SNAPPED_AT, ' UTC', '')) = CURRENT_DATE()
    )
{% endmacro %}