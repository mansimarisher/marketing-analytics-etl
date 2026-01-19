with source_dates as (

    select distinct
        ad_date::date as date_day
    from {{ ref('stg_paid_ads') }}
    where ad_date is not null

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_id,
        date_day,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(dow from date_day) as day_of_week
    from source_dates

)

select * from final
