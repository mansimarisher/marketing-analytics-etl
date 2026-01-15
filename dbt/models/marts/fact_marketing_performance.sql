-- FACT TABLE: fact_marketing_performance
-- Grain: One row per Ad per day per device per location per keyword
-- Source: stg_paid_ads

with base as (

    select
        ad_id,
        campaign_name,
        device,
        location,
        keyword,
        ad_date,

        impressions,
        clicks,
        leads,
        conversions,

        cost,
        sale_amount

    from {{ ref('stg_paid_ads') }}

),

metrics as (

    select
        ad_id,
        campaign_name,
        device,
        location,
        keyword,
        ad_date,

        impressions,
        clicks,
        leads,
        conversions,

        cost,
        sale_amount,

        -- Derived metrics (trusted)
        case
            when impressions > 0
            then clicks::float / impressions
            else 0
        end as ctr,

        case
            when clicks > 0
            then conversions::float / clicks
            else 0
        end as conversion_rate,

        case
            when cost > 0
            then sale_amount / cost
            else 0
        end as roas,

        case
            when conversions > 0
            then cost / conversions
            else null
        end as cac

    from base
)

select * from metrics
