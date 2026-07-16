{% macro eth_conversion(column_name) %}

sum({{column_name}})/ 1e18 

{% endmacro %}

{% macro stable_conversion(column_name,factor) %}

sum( {{column_name }}/power(10, {{ factor}} ) )

{% endmacro %}

{% macro stable_conv(column_name) %}

sum({{column_name}})/ 1e18 

{% endmacro %}