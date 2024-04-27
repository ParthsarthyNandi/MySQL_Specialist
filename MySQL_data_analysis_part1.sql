select * 
from actor;

select * from rental r
join inventory i
on r.inventory_id = i.inventory_id ;

select 
	first_name,
    last_name,
    email
from 
	customer;
    
select 
	count(distinct city) as most, country
from 
	city ci
right outer join 
	country co
on 
	ci.country_id = co.country_id
group by 
	country
order by 
	most desc
limit 10;

select distinct rental_duration
from film
order by rental_duration desc;

select *
from payment
where payment_id between '1' and '100';

select customer_id, rental_id, amount, payment_date
from payment
where customer_id <101 and
amount > '5' and payment_date >= '2006-01-01 00:00:00';

select title, special_features 
from film
where special_features like '%Behind the Scenes';

select distinct rating,
count(film_id) over(partition by rating)
from film;

select rental_duration, count(film_id)
from film
group by rental_duration;

select replacement_cost, count(film_id) as number_of_films, min(rental_rate) as cheapest_rental, max(rental_rate) as most_expensive_rental, avg(rental_rate)
from film
group by replacement_cost;

select customer_id, count(rental_id) as total_rentals
from rental
group by customer_id
having total_rentals<15;

select title, length, rental_rate
from film
order by length desc;

select first_name, last_name,
case 
	when store_id = '1' and active = 1 then 'store 1 active'
    when store_id = '2' and active = 1 then 'store 2 active'
    when store_id = '1' and active = 0 then 'store 1 inactive'
    when store_id = '2' and active = 0 then 'store 2 inactive'
    else 'check logic'
end as store_and_status
from customer;

select
	store_id,
    count(case when active =1 then customer_id end) as active,
    count(case when active =0 then customer_id end) as inactive
from customer
group by store_id;
 

