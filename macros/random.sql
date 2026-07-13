{% macro random_macro(column_name)%}

{% set query %}

select
distinct token_address
from {{ref('stg_token_transfers')}}
limit 10

{% endset %}

{% if execute %}
{% set results = run_query(query) %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ log (results_list, info = true) }}
{{ return(results_list) }}
{% endmacro %}