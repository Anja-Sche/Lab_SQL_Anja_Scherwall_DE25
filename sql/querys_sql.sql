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

