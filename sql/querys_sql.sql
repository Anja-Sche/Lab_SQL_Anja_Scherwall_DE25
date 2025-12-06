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
    MIN(length) AS hortest_movie_min,
    ROUND(AVG(length)) AS average_movie_min,
    MEDIAN (length) AS median_length_min,
    MAX(length) AS longest_movie_min
FROM
    film;

-- most expensive movies to rent per day
SELECT
    title,
    rental_rate,
    rental_duration,
    ROUND(rental_rate / rental_duration, 2) AS rate_per_day
FROM
    film
ORDER BY
    rate_per_day DESC
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