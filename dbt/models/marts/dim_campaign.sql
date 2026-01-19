select
    dense_rank() over (order by campaign) as campaign_id,
    campaign as campaign_name
from (
    select distinct campaign
    from {{ ref('stg_paid_ads') }}
) t
