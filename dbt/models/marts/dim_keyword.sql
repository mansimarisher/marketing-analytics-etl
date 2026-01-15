select
    distinct
    keyword
from {{ ref('stg_paid_ads') }}
