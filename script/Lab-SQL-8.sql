-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, dense_rank() over(order by length) as Ranking from film
where length != 0;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
select title, length, rating, dense_rank() over(partition by length order by rating) as Ranking from film
where length != 0;

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
select category_id, name, count(film_id) as No_of_Films from film_category as fc
join category as c using(category_id)
group by category_id;

-- 4. Which actor has appeared in the most films?
select concat(first_name, ' ',last_name) as Full_Name, count(film_id) as movies from film_actor as fa
join actor as a using(actor_id)
group by actor_id 
order by movies desc
limit 1;

-- 5. Most active customer (the customer that has rented the most number of films)
select customer_id, concat(first_name, ' ',last_name) as Full_Name, count(film_id) as No_of_movies from customer as c
join rental as r using(customer_id)
join inventory as i using(inventory_id)
group by customer_id
order by No_of_movies desc
limit 1;
