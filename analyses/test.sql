select

{{ dbt_utils.star(from= ref('stablecoin_activity_per_day')) }}

from {{ref('stablecoin_activity_per_day')}}