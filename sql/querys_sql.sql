-- movies longer than 3 hours
SELECT
    title,
    length || ' minutes' AS length
FROM
    film
WHERE
    length > 180;

-- movies which have the word "love" in the title
-- searching only for love by it self, not inside a word
SELECT
    title,
    rating,
    length || ' minutes' AS length,
    description
FROM
    film
WHERE
    regexp_matches (title, '\bLOVE\b');

-- calculating statistics on the length of all movies
SELECT
    MIN(length)::int || ' minutes' AS shortest_movie,
    ROUND(AVG(length))::int || ' minutes' AS average_movie,
    MEDIAN(length)::int || ' minutes' AS median_movie,
    MAX(length)::int || ' minutes' AS longest_movie
FROM
    film;

-- most expensive movies to rent per day
SELECT
    title,
    ROUND(rental_rate / rental_duration, 2) AS rate_per_day
FROM
    film
GROUP BY rate_per_day, title
ORDER BY
    rate_per_day DESC, title ASC
LIMIT
    10;

-- actors who played in most movies
SELECT 
    a.first_name || ' ' || a.last_name,
    COUNT(DISTINCT fa.film_id) AS number_of_films
FROM actor a
    LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY actor_name
ORDER BY number_of_films DESC
LIMIT 10; 


-- Join for top 5 paying customers
SELECT
    DISTINCT c.first_name || ' ' || c.last_name AS customer_name,
    ROUND(SUM(p.amount)) AS amount
FROM
    customer c
    INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY customer_name
ORDER BY amount DESC
LIMIT 5;


-- Join for revenue categories bring in
SELECT
    DISTINCT c.name,
    SUM(p.amount) AS amount
FROM category c
    LEFT JOIN film_category fc ON c.category_id = fc.category_id
    LEFT JOIN inventory i ON fc.film_id = i.film_id
    LEFT JOIN rental r ON r.inventory_id = i.inventory_id
    LEFT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY c.name;


-- All movies with revenue less than three dollars
SELECT
    DISTINCT f.title,
    ROUND(SUM(rental_rate),2) as film_revenue    
FROM 
    film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
HAVING film_revenue < 3
ORDER BY film_revenue ASC;


--  Times categories have been rented and the revenue
SELECT
    DISTINCT c.name,
    COUNT(rental_rate) AS times_rented,
    ROUND(SUM(p.amount),2) AS revenue_per_category,
FROM 
    film f
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON r.inventory_id = i.inventory_id
    LEFT JOIN film_category fc ON fc.film_id = f.film_id
    LEFT JOIN category c ON c.category_id = fc.category_id
    LEFT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY  c.name
ORDER BY times_rented DESC, revenue_per_category DESC;


-- Amount of movies, total income and average income per movie of each store
SELECT
    distinct i.store_id,
    COUNT(DISTINCT i.inventory_id) AS store_inventory,
    ROUND(SUM(p.amount),2) AS store_revenue,
    ROUND(store_revenue/store_inventory, 2) AS average_revenue_per_movie
FROM inventory i
    LEFT JOIN rental r ON r.inventory_id = i.inventory_id
    LEFT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY i.store_id;