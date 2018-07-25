use sakila;


select * from actor limit 10 

select first_name, last_name
from actor 

select concat(first_name,' ',last_name) as "Actor Name"
from actor 

select actor_id, first_name, last_name 
from actor 
where first_name like 'Joe%';

select first_name, last_name
from actor 
where last_name like "%GEN%"

select last_name, first_name 
from actor 
where last_name like "%LI%"
Order by 1, 2

select * from country limit 10 

select country, country_id
from country 
where country in ('Afghanistan', 'Bangladesh','China')

alter table actor 
add middle_name varchar(45); 

alter table actor 
change column middle_name middle_name varchar(45)
after first_name; 

alter table actor
alter column middle_name blobs

alter table actor 
drop column middle_name; 

select last_name, count(*)
from actor 
Group by 1;

select last_name, count(*)
from actor 
Group by 1 
having count(*) > 1
order by count(*) Desc; 

update actor 
set first_name = "Harpo"
where actor_id = 172

update actor 
set first_name = "Groucho"
where actor_id = 172

show create table address

select * from staff s 
select * from address a 
select * from payment p 

select s.first_name, s.last_name, s.address_id
from staff s 
Join address a on a.address_id = s.address_id 


select s.first_name, s.last_name, s.staff_id, p.payment_date, count(p.amount)
from staff s 
Join payment p on p.staff_id = s.staff_id
where p.payment_date between '2005-07-31' and '2005-09-01'
Group By 1

select * from film_actor a 
select * from film f 

select a.film_id, f.title, count(a.actor_id)
from film_actor a
join film f on f.film_id = a.film_id 
Group by 1

select * from inventory i 

select i.film_id, f.title, count(f.title)
from inventory i 
join film f on f.film_id=i.film_id
where f.title like 'Hunchback%'; 

-- 6 copies of Hunchback exist in the system -- 

select c.customer_id, c.first_name, c.last_name, sum(p.amount)
from customer c 
Join payment p on p.customer_id = c.customer_id 
Group by 2,3
Order by 3 

select * from film f
select * from language l 

Select * from (

	select f.title, f.language_id, l.name
    From film f 
    Join language l on l.language_id = f.language_id
    where l.name = 'English'
    ) as t where t.title like 'Q%' or t.title like 'K%' 
    

select * from film_actor fa 

Select * from ( 

	select a.actor_id, a.first_name, a.last_name, fa.film_id, f.title
    from actor a 
    Join film_actor fa on fa.actor_id = a.actor_id
    Join film f on f.film_id = fa.film_id 
) as x where x.title = 'Alone Trip' 

-- Actors in the movie Alone Trip-- 


select * from store st
select * from address ad
select * from city ci
select * from country co


select * from (

	Select 
	c.customer_id, c.address_id, c.first_name, c.last_name, c.email, 
	ad.city_id, 
	ci.country_id, 
	co.country
	from customer c
	Join address ad on ad.address_id = c.address_id
	join city ci on ci.city_id = ad.city_id
	join country co on co.country_id = ci.country_id 
    Group by 1,2,3,4,5,6,7,8,9
    
) as o where o.country = 'Canada' 

-- All Canadian Customers-- 

select * from film f
select * from category cat
select * from film_category fc


Select * from (

	select
    f.title, f.rating, f.film_id, fc.category_id, cat.name
    from film f 
    Join film_category fc on fc.film_id = f.film_id
    Join category cat on cat.category_id = fc.category_id
    Group by 1,2,3,4,5
    ) as y where y.name = 'Family' 
    
-- All Family movies-- 


select * from inventory i 

select f.film_id, f.title, count(f.title) 
from film f 
Join inventory i on i.film_id = f.film_id
Group By 1,2
Order by 3 desc

-- Most frequently rented movies-- 

Select * from store s 
select * from payment p 
select * from address ad


select 
c.store_id, c.address_id, ad.address, sum(p.amount)
from customer c 
join store s on s.store_id = c.store_id
join payment p on p.customer_id = c.customer_id
join address ad on ad.address_id = c.address_id
Group By 1,2,3 
Order by 4 desc

-- Business by Store, in dollars-- 


select * from city ci 
select * from country co 


select 
c.store_id, c.address_id, ad.address, ad.city_id, ci.city, ci.country_id, co.country 
from customer c 
join store s on s.store_id = c.store_id
join address ad on ad.address_id = c.address_id
join city ci on ci.city_id = ad.city_id 
join country co on co.country_id = ci.country_id
Group by 1,2,3,4,5,6,7

-- Store location, id, city, country-- 


select * from category cat 
select * from film_category fc 
select * from inventory i 
select * from payment p 
select * from rental r 


select cat.category_id, cat.name, fc.film_id, i.inventory_id, r.rental_id, sum(p.amount)
from category cat
join film_category fc on fc.category_id = cat.category_id
join inventory i on i.film_id = fc.film_id 
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id  
Group by 2
Order by 6 desc 
limit 5 

-- Top 5 grossing genres-- 


Create view `Top_5_Grossing_Genres` as 
	select cat.category_id, cat.name, fc.film_id, i.inventory_id, r.rental_id, sum(p.amount)
	from category cat
	join film_category fc on fc.category_id = cat.category_id
	join inventory i on i.film_id = fc.film_id 
	join rental r on r.inventory_id = i.inventory_id
	join payment p on p.rental_id = r.rental_id  
	Group by 2
	Order by 6 desc 
	limit 5 


Drop view `Top_5_Grossing_Genres` 


