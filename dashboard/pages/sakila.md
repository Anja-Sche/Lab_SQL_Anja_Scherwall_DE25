# Bra titel 

<Details title='About this page'>
    Så står info här
</Details>

```sql film
SELECT
    length,
    COUNT(length) as amount
FROM sakila.film
WHERE
    length > 180
GROUP BY length;
```

<BarChart 
    data={film}
    title=film_length
    x=length
    y=amount
    series=length
/>


