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

# 4. Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM category AS c
	JOIN film_category AS fc
	ON fc.category_id = c.category_id 
	WHERE `name` = 'family'
)
ORDER BY title;

/* 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
Note that to create a join, you will have to identify the correct tables with their primary keys and 
foreign keys, that will help you get the relevant information.*/

-- Using joins:
SELECT CONCAT(first_name, ' ', last_name) AS `name`, email
FROM customer AS cu 
JOIN address AS a ON a.address_id = cu.address_id
JOIN city AS ci ON ci.city_id = a.city_id
JOIN country AS co ON co.country_id = ci.country_id
WHERE country = 'Canada'
ORDER BY 1;

-- Using subqueries:      
SELECT CONCAT(first_name, ' ', last_name) AS `name`, email FROM customer
WHERE address_id IN (
	SELECT address_id FROM address
	WHERE city_id IN (
		SELECT city_id FROM city
		WHERE country_id IN (
			SELECT country_id FROM country
			WHERE country = 'Canada')))
ORDER BY 1;


/* 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor 
that has acted in the most number of films. First you will have to find the most prolific actor and then 
use that actor_id to find the different films that he/she starred.*/
SELECT f.title, CONCAT(a.first_name, ' ', a.last_name) AS `name`, fa.actor_id
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE a.actor_id = (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


/* 7. Films rented by most profitable customer. You can use the customer table and payment table to find 
the most profitable customer ie the customer that has made the largest sum of payments*/




/* 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the 
total_amount spent by each client.*/ 