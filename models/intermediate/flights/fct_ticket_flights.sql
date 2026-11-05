{{
    config(materialized='table')
}}
select  tf.ticket_no
    ,   tf.flight_id
    ,   tf.fare_conditions
    ,   tf.amount
    ,   case when bp.ticket_no is not null then 1 else 0 end as boarding_pass_exists
    ,   bp.boarding_no
    ,   bp.seat_no
    ,   cast('{{ run_started_at.strftime("%Y-%m-%d") }}' as date) as load_date
from    {{ ref('stg_flights__ticket_flights') }} as tf
        left join {{ ref('stg_flights__boarding_passes') }} bp
            on tf.ticket_no = bp.ticket_no and tf.flight_id = bp.flight_id