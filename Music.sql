/* Query #1  */

select first_name , sum(amount) as total_spend
from customer join payment using(customer_id)
group by customer_id
having sum(amount) > 150
order by sum(amount) desc ;

/////////////////////////////////////////////////
/*Query #2  */

SELECT count(category_id) , name
from category join film_category using(category_id)
join film using(film_id)
group by category_id
having count(category_id)> 50
order by count(category_id) desc
///////////////////////////////////////////
/*Query #3 */

	SELECT film_name, number_of_actors  
FROM ( SELECT
         f.title AS film_name,
         COUNT(a.actor_id) AS number_of_actors 
      FROM film_actor FA
         JOIN film F using (film_id)
         JOIN Actor A using (actor_id)
      GROUP BY F.title )
   sub
GROUP BY
   sub.film_name,
   sub.number_of_actors 
ORDER BY
   number_of_actors DESC LIMIT 10;

//////////////////////////////////////////////////
/* Query #4  */ 

SELECT
   p.payment_date ,
   first_name || ' '|| last_name AS customer_name,
   p.amount, AVG(P.amount) OVER (ORDER BY
   p.payment_date) AS AVG_amount_of_payment 
FROM
   payment p 
   JOIN customer C using (customer_id)
   JOIN rental R using (rental_id)   
   JOIN inventory I using (inventory_id)
   JOIN film F 
      ON F.film_id = I.inventory_id 
WHERE
   F.title = 'Lambs Cincinatti' 
GROUP BY
   P.payment_date,
   C.first_name,
   C.last_name,
   P.amount ;
