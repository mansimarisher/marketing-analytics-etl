select
    distinct
    ad_date as date,
    extract(year from ad_date)  as year,
    extract(month from ad_date) as month,
    extract(day from ad_date)   as day,
    extract(dow from ad_date)   as day_of_week
from {{ ref('stg_paid_ads') }}
