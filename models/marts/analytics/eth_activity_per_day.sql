
select 
date,
transaction_category,
count(*) as tx_count,
{{ eth_conversion('value') }}as sum_eth_values
from {{ref('transactions_enriched')}}
group by
date,
transaction_category