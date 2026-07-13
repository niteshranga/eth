select

{{ dbt_utils.star(from= ref('stg_transactions'), except= ['input']) }}

from {{ref('stg_transactions')}}