-- 1A
select first_name, last_name 
from actor;

-- 1B
select upper(concat(first_name, " ", last_name)) as "Actor Name"
from actor;

-- 2A
select first_name, last_name 
from actor
where first_name = "joe";

-- 2B
select first_name, last_name 
from actor
where last_name like "%gen%";

-- 2C
select first_name, last_name 
from actor
where last_name like "%li%"
order by last_name, first_name;

-- 2d 
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` BLOB NULL AFTER `last_update`;

-- 3b
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

-- 4a
select last_name, count(last_name)
from actor
group by last_name;

-- 4b
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) > 1;

-- 4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

-- 4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' and last_name = 'WILLIAMS';

-- 5a
CREATE TABLE `sakila`.`address` (
  `address_id` SMALLINT(5) UNSIGNED NULL AUTO_INCREMENT,
  `address` VARCHAR(50) NULL,
  `address2` VARCHAR(50) NULL,
  `district` VARCHAR(20) NULL,
  `city_id` SMALLINT(5) UNSIGNED NULL,
  `postal_code` VARCHAR(10) NULL,
  `phone` VARCHAR(20) NULL,
  `location` GEOMETRY NULL,
  `last_update` TIMESTAMP(15) NULL,
  `` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`));

-- 6a
select a.first_name, a.last_name, b.address
from staff a inner join address b on a.address_id = b.address_id;

-- 6b
select a.first_name, a.last_name, count(b.payment_date)
from staff a join payment b on a.staff_id = b.staff_id
where b.payment_date like '%2005-08%'
group by first_name
;

-- 6c
select a.title, count(b.actor_id) number_of_actors
from film_actor b inner join film a on a.film_id = b.film_id
group by a.title;

-- 6d
select a.title, count(b.film_id)
from film a join inventory b on a.film_id = b.film_id
where a.title = 'Hunchback Impossible';

-- 6e
select a.first_name, a.last_name, sum(b.amount) as 'Total Amount Paid'
from customer a join payment b on a.customer_id = b.customer_id
group by a.first_name, a.last_name
order by a.last_name;

 -- 7a
select a.title, bob.name 
from film a 
join (select * from language where name = "english") bob on a.language_id = bob.language_id 
where title like "K%" or title like "Q%";

-- 7b
select b.first_name, b.last_name, a.title, c.film_id
from actor b join film_actor c on b.actor_id = c.actor_id 
join (select * from film where title = "Alone Trip") a on c.film_id = a.film_id;

-- 7c 
select a.first_name, a.last_name, a.email, d.country
from customer a 
join address b on a.address_id = b.address_id 
join city c on b.city_id = c.city_id join country d on c.country_id = d.country_id
where d.country = "Canada";

-- 7d
select a.title, c.name 
from film a 
join film_category b on a.film_id = b.film_id 
join category c on b.category_id = c.category_id
where c.name = "family";

-- 7e
select a.title, count(a.title) as rental_frequency
from film a 
join inventory b on a.film_id = b.film_id
join rental c on b.inventory_id = c.inventory_id
group by a.title
order by rental_frequency  desc;

-- 7f
select a.store_id, sum(c.amount) as amount
from staff a join payment c on a.staff_id = c.staff_id
join store b on a.store_id = b.store_id
group by a.store_id;

-- 7g
select a.store_id, c.city, d.country
from store a 
join address b on a.address_id = b.address_id
join city c on b.city_id = c.city_id join country d on c.country_id = d.country_id;

-- 7h
select a.name, sum(e.amount) as gross
from category a join film_category b on a.category_id = b.category_id
join inventory c on b.film_id = c.film_id 
join rental d on c.inventory_id = d.inventory_id
join payment e on d.rental_id = e.rental_id
group by a.name 
order by gross desc
limit 5
;

-- 8a
CREATE VIEW top_5_gross AS select a.name, sum(e.amount) as gross
from category a join film_category b on a.category_id = b.category_id
join inventory c on b.film_id = c.film_id 
join rental d on c.inventory_id = d.inventory_id
join payment e on d.rental_id = e.rental_id
group by a.name 
order by gross desc
limit 5
;

-- 8b
SELECT * FROM top_5_gross;

-- 8c
DROP VIEW top_5_gross;





















