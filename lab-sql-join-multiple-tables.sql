USE sakila;

#1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store AS s
INNER JOIN address AS a
ON s.address_id = a.address_id
INNER JOIN city AS c
ON c.city_id = a.city_id
INNER JOIN country AS co
ON c.country_id = co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(amount) AS total_amount
FROM store AS s
INNER JOIN staff st 
ON s.store_id = st.store_id
INNER JOIN payment AS p
ON st.staff_id = p.staff_id
GROUP BY 1;

#3. What is the average running time of films by category?
# THIS SPACE IS TO WRITE THE "CREATE TEMPORARY TABLE avg_running_time" clause. 
SELECT `name`, ROUND(AVG(length),2) AS avg_running_time
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id
GROUP BY `name`
ORDER BY 1;

#4. Which film categories are longest?
# Using the previous query, we add the CREATE TEMPORARY TABLE clause for answer this question.
SELECT `name`, avg_running_time
FROM avg_running_time
ORDER BY avg_running_time DESC
LIMIT 1;

#5. Display the most frequently rented movies in descending order.
SELECT title, COUNT(rental_id) AS num_rents
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id 
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY 2 DESC;

#6. List the top five genres in gross revenue in descending order.
SELECT * FROM payment;
SELECT `name` AS genre, SUM(amount) AS revenue
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
ON p.rental_id = r.rental_id
GROUP BY genre
ORDER BY 2 DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, i.inventory_id, s.store_id
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN store AS s
ON s.store_id = i.store_id
WHERE title = 'Academy Dinosaur'
HAVING s.store_id = 1;

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM store;
SELECT * FROM rental;

SELECT title, r.inventory_id, store_id
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
WHERE title = 'Academy Dinosaur';

#No, it seems is not available.