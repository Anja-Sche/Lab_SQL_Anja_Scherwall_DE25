# Bra titel 

<Details title='About this page'>
    Så står info här
</Details>

## Movies over three hours
<Details title='More information'>
    
</Details>

```sql film_lengths
SELECT
    length::int|| ' minutes' AS movie_length,
    COUNT(length) as amount,
FROM sakila.film
WHERE 
    length > 180 
GROUP BY length
ORDER BY length;
```

<DataTable data={film_lengths} />

## Actors who played in most movies
<Details title='Information about graph'>
    The graph shows the the actors who have played in the most movies.           
    It also shows the amount of movies they have played in.
</Details> 


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


```sql price_per_day
SELECT
    COUNT(rate_per_day)::int AS amount_of_movies,
    rate_per_day,
    rental_rate,
    rental_duration
FROM
    sakila.film
GROUP BY rate_per_day,rental_rate,rental_duration
ORDER BY
    rate_per_day DESC; 
```


<DataTable data={price_per_day} />

<Dropdown data={store_revenue} name=store value=store_id_str 
 title="Select store">
    <DropdownOption value="%" valueLabel="Stores"/>
</Dropdown>

```sql store_revenue
SELECT 
    category,
    ROUND(SUM(amount),2) AS store_revenue,
    'Store ' || REPLACE(CAST(store_id AS VARCHAR), '.0', '') AS store_id_str
FROM sakila.income
WHERE store_id_str LIKE '${inputs.store.value}'
GROUP BY category, store_id_str
ORDER BY store_id_str;
```


<BarChart 
    data={store_revenue}
    title=Store revenue each category
    x=category
    y=store_revenue
    series=store_id_str
/>