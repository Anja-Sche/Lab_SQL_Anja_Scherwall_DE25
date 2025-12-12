SELECT *,
ROUND(rental_rate / rental_duration,2) as rate_per_day
FROM staging.film;