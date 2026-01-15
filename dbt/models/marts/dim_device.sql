select
    distinct
    device
from {{ ref('stg_paid_ads') }}
