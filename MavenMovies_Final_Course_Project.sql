use mavenmovies;
/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

-- select * from store;
select staff.first_name, staff.last_name, store.store_id, address.address, address.district,
	city.city, country.country
from staff
left join store
on staff. store_id=store.store_id
left join address on store.address_id = address.address_id
left join city on city.city_id=address.city_id
left join country on country.country_id=city.country_id;
	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

select inventory.inventory_id, inventory.store_id,
	film.title as name_of_film, film.rating, film.rental_rate, film.replacement_cost
from inventory
left join film on inventory.film_id=film.film_id
group by film.rating;

/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

select count(inventory.inventory_id) as number_inventory_items, inventory.store_id, film.rating
from inventory
left join film on inventory.film_id=film.film_id
group by film.rating, inventory.store_id;

/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

SELECT 
	store_id, 
    category.name AS category, 
	COUNT(inventory.inventory_id) AS films, 
    AVG(film.replacement_cost) AS avg_replacement_cost, 
    SUM(film.replacement_cost) AS total_replacement_cost
    
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film.film_id = film_category.film_id
	LEFT JOIN category
		ON category.category_id = film_category.category_id

GROUP BY 
	store_id, 
    category.name;

/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

select customer.first_name, customer.last_name, customer.store_id,
	address.address, city.city, country.country 
from customer
left join address
on customer.address_id=address.address_id
left join city
on address.city_id=city.city_id
left join country
on city.country_id=country.country_id;

/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

select
	customer.first_name,
    customer.last_name,
    count(payment.rental_id),
    sum(payment.amount)
from payment
left join customer
on payment.customer_id=customer.customer_id
group by payment.customer_id
order by sum(payment.amount) desc;
    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

select
	'investor' as type,
    first_name,
    last_name,
    company_name
from investor
union
select
	'advisor' as type,
    first_name,
    last_name,
    null
from advisor;

/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/
select * from actor_award;
select distinct(awards) from actor_award;
select 
case 
	when awards = 'Emmy, Oscar, Tony 'then '3 Awards'
    when awards in ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') then '2 Awards'
    else '1 award'
end as number_of_awards,
 AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
from actor_award
GROUP BY 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 Awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 Awards'
		ELSE '1 award'
	END
;