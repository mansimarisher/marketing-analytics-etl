{{ config(materialized='view') }}

select
    ad_id,
    campaign_name,
    keyword,
    device,
    location,
    ad_date,

    impressions,
    clicks,
    leads,
    conversions,

    cost,
    sale_amount,

    case when impressions > 0 then clicks::float / impressions end as ctr,
    case when clicks > 0 then conversions::float / clicks end as conversion_rate,
    case when cost > 0 then sale_amount / cost end as roas,
    case when conversions > 0 then cost / conversions end as cac,

    created_at
from public.stg_paid_ads
where ad_date is not null
