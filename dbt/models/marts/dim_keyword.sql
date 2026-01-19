select
    dense_rank() over (order by keyword) as keyword_id,
    keyword
from (
    select distinct keyword
    from  {{ ref('stg_paid_ads') }}

) t
