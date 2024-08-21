use mavenfuzzyfactory;

select * from website_sessions;

select * from website_pageviews where website_session_id = 20;

select * from orders;

-- Find which ad campaign is performing the best?

select utm_source, utm_campaign, http_referer as referring_domain, count(distinct website_session_id)
from website_sessions
where created_at <'2012-04-12'
group by utm_source,utm_campaign,referring_domain
order by count(distinct website_session_id) desc;

-- Find the order CVR for gsearch non-brand to find how it is performing actually?

select count(distinct(w.website_session_id)) as sessions,
count(distinct(o.order_id)) as orders,
(count(distinct(o.order_id)) /count(distinct(w.website_session_id)))*100 as CVR_percent
from website_sessions w
left join orders o
on w.website_session_id = o.website_session_id
where w.created_at < '2012-04-14' and utm_source = 'gsearch' and utm_campaign = 'nonbrand';

-- Analyze and find which month had more orders in total?

select * from orders;

select month(created_at) as month_ordered, count(order_id) as num_of_orders
from orders
group by month_ordered
order by num_of_orders DESC;

-- Analyse how we performed based on year? Find year and count of orders aand group the count based on year.

select year(created_at) as year_of_sale, count(order_id) as num_order_for_the_year
from orders
group by year_of_sale;

-- Make a pivot table using count and case in order?

select * from orders;

select * from products; -- so there are only 4 products

select distinct(items_purchased) as items_purchased,count(order_id) as num_of_orders
from orders
group by items_purchased;

-- now find which product was ordereed and was it a part of one item per order or 2 item per order?

select * from orders
where items_purchased = 2;

select 
	primary_product_id,
    count(distinct case when items_purchased = 1 then order_id else null end) as order_w_1,
    count(distinct case when items_purchased = 2 then order_id else null end) as order_w_2,
	count(order_id) as orders_total
from orders
group by 1;

-- Pull gsearch nonbrand trended sessions volumn by week?

select 
	min(date(created_at)) as week_start_date,
    count(distinct website_session_id) as sessions
from website_sessions
where created_at < '2012-05-10' and utm_source = 'gsearch' and utm_campaign = 'nonbrand'
group by 
	year(created_at),
    week(created_at);
    
    
select 
	w.device_type,
	count(distinct w.website_session_id),
	count(distinct order_id), 
    count(distinct order_id)/count(distinct w.website_session_id)
from website_sessions w
left join orders o
on w.website_session_id = o.website_session_id
where w.created_at < '2012-05-11' 
group by w.device_type;

-- pivot table in SQL.

select
	min(date(created_at)) as week_start_date,
    count(case when device_type = 'mobile' then website_session_id else null end) as mob_sessions,
	count(case when device_type = 'desktop' then website_session_id else null end) as dtop_sessions
from website_sessions
where created_at > '2012-04-15' 
	and created_at < '2012-06-09' 
    and utm_source = 'gsearch' 
    and utm_campaign = 'nonbrand'
group by 
	year(created_at),
    week(created_at);

select price_usd as price from orders
where price_usd>10;

create temporary table temp_table_order
as
select * from orders
where order_id >100;