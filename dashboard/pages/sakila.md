# Bra titel 

<Details title='About this page'>
    Så står info här
</Details>



```sql film_lengths
SELECT
    length::int|| ' minutes' AS length,
    COUNT(length) as amount
FROM sakila.film
WHERE 
    length > 180 
GROUP BY length
ORDER BY length;
```

<BarChart 
    data={film_lengths}
    title=film_length
    x=length
    y=amount
/>


```sql actor_most_movies
SELECT 
    actor_name,
    COUNT(DISTINCT film_id) AS number_of_films
FROM sakila.actor_movies    
GROUP BY actor_name
ORDER BY number_of_films DESC
LIMIT 10; 
```

<BarChart 
    data={actor_most_movies}
    title=Actor with most movies
    x=actor_name
    y=number_of_films
    swapXY=true
/>


```sql Most_expensive_movies
SELECT
    COUNT(rate_per_day)::int AS amount_of_movies,
    rental_rate,
    rental_duration,
    rate_per_day,
FROM
    sakila.film
GROUP BY rate_per_day,rental_rate,rental_duration
ORDER BY
    rate_per_day DESC; 
```

<BarChart 
    data={Most_expensive_movies}
    title=Movie cost per day
    x=rate_per_day
    y=amount_of_movies
/>


