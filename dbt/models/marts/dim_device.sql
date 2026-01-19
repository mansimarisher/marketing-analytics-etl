select
    dense_rank() over (order by device) as device_id,
    device
from (
    select distinct device
    from  {{ ref('stg_paid_ads') }}

) t

-- star schema refactor
