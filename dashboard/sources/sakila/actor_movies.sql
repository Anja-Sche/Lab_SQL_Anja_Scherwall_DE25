SELECT 
    a.first_name || ' ' || a.last_name AS actor_name,
    fa.film_id
FROM staging.actor a
    LEFT JOIN staging.film_actor fa ON a.actor_id = fa.actor_id;