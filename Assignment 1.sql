--- Question 1: Identify the primary keys and foreign keys in maven movies db. Discuss the differences 
--- Answer 1:   Primary Keys:
                SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE
                WHERE CONSTRAINT_NAME = 'PRIMARY'
                AND TABLE_SCHEMA = 'mavenmovies';


---             Foreign Keys:
                SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME
                FROM information_schema.KEY_COLUMN_USAGE
                WHERE CONSTRAINT_NAME != 'PRIMARY'
                AND REFERENCED_TABLE_NAME IS NOT NULL
                AND TABLE_SCHEMA = 'mavenmovies';

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
--- Answer 5: SELECT * FROM customer WHERE active = 1;


--- Question 6: List of all rental IDs for customer with ID 1. 
--- Answer 6: SELECT customer_id, rental_id FROM rental WHERE customer_id = 1;


--- Question 7: Display all the films whose rental duration is greater than 5 . 
--- Answer 7: SELECT film_id, title, rental_duration FROM film WHERE rental_duration > 5;


--- Question 8: List the total number of films whose replacement cost is greater than $15 and less than $20. 
--- Answer 8: SELECT COUNT(*) as total_no_of_film FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;


--- Question 9: Display the count of unique first names of actors. 
--- Answer 9: SELECT COUNT(DISTINCT first_name) FROM actor;


--- Question 10:  Display the first 10 records from the customer table . 
--- Answer 10: SELECT * FROM customer LIMIT 10;


--- Question 11: Display the first 3 records from the customer table whose first name starts with ‘b’. 
--- Answer 11: SELECT first_name* FROM customer WHERE first_name LIKE 'B%' LIMIT 3;


--- Question 12: Display the names of the first 5 movies which are rated as ‘G’. 
--- Answer 12: SELECT title, rating FROM film WHERE rating = 'G' LIMIT 5;


--- Question 13: Find all customers whose first name starts with "a". 
--- Answer 13: SELECT * FROM customer WHERE first_name LIKE 'A%';


--- Question 14: Find all customers whose first name ends with "a". 
--- Answer 14: SELECT * FROM customer WHERE first_name LIKE '%a';


--- Question 15:  Display the list of first 4 cities which start and end with ‘a’ . 
--- Answer 15: SELECT city FROM city WHERE city LIKE 'A%' AND city LIKE '%a' LIMIT 4; OR  SELECT city FROM city WHERE city LIKE 'a%a' LIMIT 4;



--- Question 16: Find all customers whose first name have "NI" in any position. 
--- Answer 16: SELECT first_name * FROM customer WHERE first_name LIKE '%NI%';


--- Question 17:  Find all customers whose first name have "r" in the second position .
--- Answer 17: SELECT first_name * FROM customer WHERE first_name LIKE '_r%';


--- Question 18:  Find all customers whose first name starts with "a" and are at least 5 characters in length. 
--- Answer 18: SELECT first_name* FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

--- Question 19: Find all customers whose first name starts with "a" and ends with "o". 
--- Answer 19: SELECT first_name * FROM customer WHERE first_name LIKE 'A%' AND first_name LIKE '%o';

--- Question 20:  Get the films with pg and pg-13 rating using IN operator. 
--- Answer 20: SELECT title FROM film WHERE rating IN ('PG', 'PG-13');

--- Question 21:  Get the films with length between 50 to 100 using between operator. 
--- Answer 21: SELECT title, length FROM film WHERE length BETWEEN 50 AND 100;

--- Question 22: Get the top 50 actors using limit operator. 
--- Answer 22: SELECT * FROM actor LIMIT 50;

--- Question 23:  Get the distinct film ids from inventory table. 
--- Answer 23: SELECT DISTINCT film_id FROM inventory;
