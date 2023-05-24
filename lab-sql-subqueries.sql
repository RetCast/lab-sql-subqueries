USE sakila;

SELECT * FROM film;
SELECT * FROM inventory;

# 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(*) AS nummber_of_movies
FROM inventory
WHERE film_id = (
	SELECT film_id
	FROM film
	WHERE title = 'Hunchback Impossible');

# 2. List all films whose length is longer than the average of all the films.
SELECT film_id, title, `length`
FROM film
WHERE length > (
	SELECT AVG(length)
	FROM film)
ORDER BY `length`;

# 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name, ' ', last_name) AS `name`
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor 
	WHERE film_id IN (
		SELECT film_id
		FROM film 
		WHERE title = 'Alone Trip'));




/*4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as family films.*/
/* 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
Note that to create a join, you will have to identify the correct tables with their primary keys and 
foreign keys, that will help you get the relevant information.*/
/* 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor 
that has acted in the most number of films. First you will have to find the most prolific actor and then 
use that actor_id to find the different films that he/she starred.*/
/* 7. Films rented by most profitable customer. You can use the customer table and payment table to find 
the most profitable customer ie the customer that has made the largest sum of payments*/
/* 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the 
total_amount spent by each client.*/ 