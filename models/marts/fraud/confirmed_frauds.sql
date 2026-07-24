{{ config(group='fraud_risk', access='protected') }}

select
*
from {{ ref('transactions_enriched')}}

