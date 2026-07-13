{% macro eth_conversion(column_name) %}

sum({{column_name}})/ 1e18 

{% endmacro %}

{% macro stable_conversion(column_name) %}

sum({{column_name}})/ 1e6 

{% endmacro %}
