select
    dense_rank() over (order by location) as location_id,
    location
from (
    select distinct location
    from {{ ref('stg_paid_ads') }}

) t
