use mavenmovies;

select i.inventory_id, i.store_id, f.title, f.description
from film f
join inventory i
on f.film_id = i.film_id;

select f.title, count(fa.actor_id) as number_of_actors
from film_actor fa
left join film f
on fa.film_id = f.film_id
group by f.title;

select first_name, last_name, title
from film
inner join film_actor
on film.film_id = film_actor.film_id
inner join actor
on film_actor.actor_id = actor.actor_id;

select distinct title, description
from film
inner join inventory
on film.film_id = inventory.film_id and inventory.store_id = '2';

select
	'investor' as type,
    first_name,
    last_name
from
	investor
union
select
	'staff' as type,
	first_name,
    last_name
from staff;





