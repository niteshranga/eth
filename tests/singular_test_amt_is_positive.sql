-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where total_amount < 0 to make the test fail.
select

    sum(value) as total_amount
from {{ ref('transactions_enriched') }}
having total_amount < 0