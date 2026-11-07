{{
    config(materialized='table')
}}
select  passenger_id
    ,   airline
from    {{ ref('airline_employee_passengers') }}