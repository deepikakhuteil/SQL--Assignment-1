--- Question 1: Identify the primary keys and foreign keys in maven movies db. Discuss the differences 
--- Answer 1:   Primary Keys:
--- •	        actor.actor_id
--- •	        address.address_id
--- •		    advisor.advisor_id
--- •		    category.category_id
--- •		    city.city_id
--- •		    country.country_id
--- •		    customer.customer_id
--- •		    film.film_id
--- •		    film_text.film_id
--- •		    inventory.inventory_id
--- •		    investor.investor_id
--- •		    language.language_id
--- •		    payment.payment_id
--- •		    rental.rental_id
--- •		    staff.staff_id
--- •		    store.store_id
--- •		    actor_award.actor_award_id

---             Foreign Keys:
--- •	  1.	Address Table:
--- •	    	address.city_id → References city.city_id

--- •	  2.	City Table:
--- •	    	city.country_id → References country.country_id

--- •	  3.	Customer Table:
--- •	    	customer.store_id → References store.store_id
--- •	    	customer.address_id → References address.address_id

--- •	  4.	Film Table:
--- •	    	film.language_id → References language.language_id
--- •	    	film.original_language_id → References language.language_id

--- •	  5.	Inventory Table:
--- •	    	inventory.store_id → References store.store_id
--- •	    	inventory.film_id → References film.film_id

--- •	  6.	Rental Table:
--- •	    	rental.customer_id → References customer.customer_id
--- •	    	rental.inventory_id → References inventory.inventory_id
--- •	    	rental.staff_id → References staff.staff_id

--- •	  7.	Staff Table:
--- •	    	staff.address_id → References address.address_id
--- •	    	staff.store_id → References store.store_id

--- •	  8.	Store Table:
--- •	    	store.manager_staff_id → References staff.staff_id
--- •	    	store.address_id → References address.address_id

--- •	  9.	Film Actor Table:
--- •	    	film_actor.actor_id → References actor.actor_id
--- •	    	film_actor.film_id → References film.film_id

--- •	  10.	Film Category Table:
--- •	    	film_category.film_id → References film.film_id
--- •	    	film_category.category_id → References category.category_id

--- •	  11.	Payment Table:
--- •	    	payment.customer_id → References customer.customer_id
--- •	    	payment.staff_id → References staff.staff_id
--- •	    	payment.rental_id → References rental.rental_id

--- •	  12.	Actor Award Table:
--- •	    	actor_award.actor_id → References actor.actor_id

---       DIFFENERNCE BETWEEN PRIMARY KEY AND FOREIGN KEY

---       Feature                Primary Key                                                  Foreign Key

---       Definition             A unique identifier for each record in a table.               A reference to the primary key in another table.
---       Uniqueness             Must be unique for each record in the table.                  Can have duplicate values in the referencing table.
---       Null Values            Cannot be null (must have a value).                           Can contain null values.
---       Purpose                Ensures each record is unique and easily identifiable.        Links two tables together by referencing the primary key.
---       Table                  Exists in the same table it defines.                          Exists in one table, but refers to another table.
---       Example                In a student table, "student_id" as a primary key.            In an enrollment table, "student_id" as a foreign key.


--- Question 2: List all details of actors
--- Answer 2: SELECT * FROM actor;


--- Question 3: List all customer information from DB. 
--- Answer 3: SELECT * FROM customer;


--- Question 4: List different countries. 
--- Answer 4: SELECT DISTINCT country FROM country;


--- Question 5: Display all active customers. 
--- Answer 5: SELECT * FROM customer WHERE active = TRUE;


--- Question 6: List of all rental IDs for customer with ID 1. 
--- Answer 6: SELECT rental_id FROM rental WHERE customer_id = 1;


--- Question 7: Display all the films whose rental duration is greater than 5 . 
--- Answer 7: SELECT * FROM film WHERE rental_duration > 5;


--- Question 8: List the total number of films whose replacement cost is greater than $15 and less than $20. 
--- Answer 8: SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;
--- Total count 214


--- Question 9: Display the count of unique first names of actors. 
--- Answer 9: SELECT COUNT(DISTINCT first_name) FROM actor;
--- Total count 128


--- Question 10:  Display the first 10 records from the customer table . 
--- Answer 10: SELECT * FROM customer LIMIT 10;


--- Question 11: Display the first 3 records from the customer table whose first name starts with ‘b’. 
--- Answer 11: SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;


--- Question 12: Display the names of the first 5 movies which are rated as ‘G’. 
--- Answer 12: SELECT title FROM film WHERE rating = 'G' LIMIT 5;


--- Question 13: Find all customers whose first name starts with "a". 
--- Answer 13: SELECT * FROM customer WHERE first_name LIKE 'A%';


--- Question 14: Find all customers whose first name ends with "a". 
--- Answer 14: SELECT * FROM customer WHERE first_name LIKE '%a';


--- Question 15:  Display the list of first 4 cities which start and end with ‘a’ . 
--- Answer 15: SELECT city FROM city WHERE city LIKE 'A%' AND city LIKE '%a' LIMIT 4; OR  SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;



--- Question 16: Find all customers whose first name have "NI" in any position. 
--- Answer 16: SELECT * FROM customer WHERE first_name LIKE '%NI%';


--- Question 17:  Find all customers whose first name have "r" in the second position .
--- Answer 17: SELECT * FROM customer WHERE first_name LIKE '_r%';


--- Question 18:  Find all customers whose first name starts with "a" and are at least 5 characters in length. 
--- Answer 18: SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;



--- Question 19: Find all customers whose first name starts with "a" and ends with "o". 
--- Answer 19: SELECT * FROM customer WHERE first_name LIKE 'A%' AND first_name LIKE '%o';

--- Question 20:  Get the films with pg and pg-13 rating using IN operator. 
--- Answer 20: SELECT title FROM film WHERE rating IN ('PG', 'PG-13');

--- Question 21:  Get the films with length between 50 to 100 using between operator. 
--- Answer 21: SELECT title FROM film WHERE length BETWEEN 50 AND 100;

--- Question 22: Get the top 50 actors using limit operator. 
--- Answer 22: SELECT * FROM actor LIMIT 50;

--- Question 23:  Get the distinct film ids from inventory table. 
--- Answer 23: SELECT DISTINCT film_id FROM inventory;
