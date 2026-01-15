select
    distinct
    campaign_name
from {{ ref('stg_paid_ads') }}
