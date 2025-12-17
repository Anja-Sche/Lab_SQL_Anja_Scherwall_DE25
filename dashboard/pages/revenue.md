---
title: Revenue
---
- Klick on the informatoin text underneath the names to se information about the result.<LineBreak lines=2/>

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

```sql stores
SELECT
    DISTINCT 'Store ' || CAST(store_id::int AS VARCHAR) AS store_id_str
FROM sakila.income;
```

<Dropdown data={stores} name=store value=store_id_str 
 title="Select store">
    <DropdownOption value="%" valueLabel="Both Stores"/>
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