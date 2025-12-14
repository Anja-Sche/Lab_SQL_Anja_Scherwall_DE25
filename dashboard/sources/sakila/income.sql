SELECT
    i.store_id,
    i.inventory_id,
    p.amount,
    c.name as category,
    f.rental_rate
FROM staging.inventory i
    LEFT JOIN staging.rental r ON r.inventory_id = i.inventory_id
    LEFT JOIN staging.payment p ON p.rental_id = r.rental_id
    LEFT JOIN staging.film f ON f.film_id = i.film_id
    LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
    LEFT JOIN staging.category c ON c.category_id = fc.category_id;