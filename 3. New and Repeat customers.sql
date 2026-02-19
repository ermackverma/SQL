--create table customer_orders (
--order_id integer,
--customer_id integer,
--order_date date,
--order_amount integer
--);

--insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
--,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
--,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


--select * from customer_orders;

with cte1 as(
select 
*, FIRST_VALUE(order_date) over(partition by customer_id order by customer_id) as first_order_date
from customer_orders

)
, cte2 as (
select *
, case when order_date = first_order_date then 1 else 0 end as first_visit_flag
, case when order_date != first_order_date then 1 else 0 end as repeat_visit_flag
from cte1
)

select order_date, sum(first_visit_flag) as new_customers, sum(repeat_visit_flag) as repeat_customers
from cte2
group by order_date
order by order_date


----- Second Approach

WITH first_visit AS (
    SELECT customer_id, MIN(order_date) AS first_visit_date
    FROM customer_orders
    GROUP BY customer_id
)
SELECT co.order_date,
       SUM(CASE WHEN co.order_date = fv.first_visit_date THEN 1 ELSE 0 END) AS first_visit_flag,
       SUM(CASE WHEN co.order_date != fv.first_visit_date THEN 1 ELSE 0 END) AS repeat_visit_flag
FROM customer_orders co
INNER JOIN first_visit fv ON co.customer_id = fv.customer_id
GROUP BY co.order_date;
