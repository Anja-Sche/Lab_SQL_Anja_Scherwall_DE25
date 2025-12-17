---
title: Actors
---
- Klick on the informatoin text underneath the name to se information abot the result.<LineBreak lines=2/>

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
