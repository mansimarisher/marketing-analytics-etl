select
    distinct
    location
from {{ ref('stg_paid_ads') }}
