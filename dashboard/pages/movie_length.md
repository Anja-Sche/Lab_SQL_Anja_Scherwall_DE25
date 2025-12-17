---
title: Movie length
---
- Klick on the informatoin text underneath the names to se information about the result.<LineBreak lines=2/>

## Movies over three hours
<Details title='Information about table'>
    This table shows the different lengths of movies longer than three hours (180 min).
    <LineBreak lines=1/>
    It also shows the amount of movies with those lengths.
    <LineBreak lines=2/>
    Note this statistics uses data from all movies and categories.    
</Details>

```sql film_lengths
SELECT
    length::int|| ' minutes' AS movie_length,
    COUNT(length) ||' movies' as movie_amount,
FROM sakila.film
WHERE 
    length > 180 
GROUP BY length
ORDER BY length;
```

<DataTable data={film_lengths}/>


## Length statistics of movies
<Details title='Information about table'>
    This table will show: <LineBreak lines=1/>
    - length of the shortest movie <LineBreak lines=1/> 
    - average length of all movies <LineBreak lines=1/>     
    - median length of all movies <LineBreak lines=1/>    
    - length of the longest movie <LineBreak lines=2/>
    Note this statistics uses data from all movies and categories.    
</Details>

```sql film_statistics
SELECT
    MIN(length)::int || ' minutes' AS shortest_movie,
    ROUND(AVG(length))::int || ' minutes' AS average_movie,
    MEDIAN(length)::int || ' minutes' AS median_movie,
    MAX(length)::int || ' minutes' AS longest_movie
FROM sakila.film;
```

<DataTable data={film_statistics}/>