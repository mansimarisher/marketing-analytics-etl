-- FACT TABLE: fact_marketing_performance
-- Grain: One row per Ad per day per device per location per keyword
-- Source: stg_paid_ads

select
    s.ad_id,

    d.date_id,
    c.campaign_id,
    dv.device_id,
    l.location_id,
    k.keyword_id,

    -- base metrics
    s.impressions,
    s.clicks,
    s.conversions,
    s.cost,
    s.sale_amount,

    -- derived metrics
    case when s.impressions > 0
        then s.clicks::float / s.impressions
    end as ctr,

    case when s.clicks > 0
        then s.cost / s.clicks
    end as cpc,

    case when s.clicks > 0
        then s.conversions::float / s.clicks
    end as conversion_rate,

    case when s.cost > 0
        then s.sale_amount / s.cost
    end as roas,

    s.sale_amount - s.cost as profit

from {{ ref('stg_paid_ads') }} s

left join {{ ref('dim_campaign') }} c
    on s.campaign = c.campaign_name

left join {{ ref('dim_device') }} dv
    on s.device = dv.device

left join {{ ref('dim_location') }} l
    on s.location = l.location

left join {{ ref('dim_keyword') }} k
    on s.keyword = k.keyword

left join {{ ref('dim_date') }} d
    on s.ad_date::date = d.date_day

where s.ad_date is not null



    


