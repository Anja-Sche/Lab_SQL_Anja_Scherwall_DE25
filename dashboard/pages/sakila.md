# Statisics from sakila database

<Details title='About this dashboard'>
    This dashboard visualize analyses from the sakila database. 
    <LineBreak lines=2/>
    Firstly you will see statistics on movie lengths and the actors who have played in the most movies.<LineBreak lines=1/>
    Then you will see statistics on rental rate and store revenue.
</Details>

<LineBreak lines=1/>

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



## Actors who played in most movies
<Details title='Information about graph'>
    The graph shows the top ten actors who have played in the most movies.
    <LineBreak lines=1/>           
    It also shows the amount of movies they have played in.
    <LineBreak lines=2/>
    Note there are three more actors who have played in 35 movies.
</Details> 


```sql actor_most_movies
SELECT 
    actor_name,
    COUNT(DISTINCT film_id) AS number_of_films
FROM sakila.actor_movies    
GROUP BY actor_name
ORDER BY number_of_films DESC,
         actor_name ASC
LIMIT 10; 
```

<BarChart 
    data={actor_most_movies}
    title=Actor with most movies
    x=actor_name
    y=number_of_films
    swapXY=true
    labels=true
    sort=false
/>

## The rate of a movie, per day
<Details title='Information about graph'>
    The graph shows different rates per day for movie rentals.
    <LineBreak lines=1/>
    It also shows the amount of movies with that daily rate.
    <LineBreak lines=2/>
    Note this statistics uses data from all movies and categories. The rental duration can differ.           

</Details> 

```sql movies_price_per_day
SELECT
    COUNT(rate_per_day)::int AS amount_of_movies,
    CAST(rate_per_day AS VARCHAR) || ' $' AS rate_per_day_str,
FROM
    sakila.film
GROUP BY rate_per_day_str
ORDER BY
    rate_per_day_str DESC; 
```


<BarChart 
    data={movies_price_per_day}
    title="Movie amount"
    x=rate_per_day_str
    y=amount_of_movies
    sort=false
    labels=true
/>

## Revenue for each category
<Details title='Information about graph'>
    This graph shows the total revenue for each category.
    <LineBreak lines=1/>
    You can also choose to see the revenue per category for each store.
</Details>

<Dropdown data={store_revenue} name=store value=store_id_str 
 title="Select store">
    <DropdownOption value="%" valueLabel="Stores"/>
</Dropdown>

```sql store_revenue
SELECT 
    category,
    ROUND(SUM(amount),2) AS store_revenue,
    'Store ' || CAST(store_id::int AS VARCHAR) AS store_id_str
FROM sakila.income
WHERE store_id_str LIKE '${inputs.store.value}'
GROUP BY category, store_id_str
ORDER BY category;
```


<BarChart 
    data={store_revenue}
    title=Revenue
    x=category
    y=store_revenue
    series=store_id_str
    sort=false
    swapXY=true
    labels=true
    seriesLabels=false
    labelFmt="#,### $"
/>