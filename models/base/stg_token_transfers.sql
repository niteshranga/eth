{{ config(materialized='table') }}

select 
date,
token_address,
transaction_hash,
value

from {{source('eth','token_transfers')}}
