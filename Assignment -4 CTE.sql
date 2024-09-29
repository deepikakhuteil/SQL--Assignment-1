-- Question 1  Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
-- Answer 1. The actor_award table in the Sakila database is the table that violate First Normal Form (1NF).
--           Here, the awards column violates 1NF because it contains multiple values (multiple awards) in a single field.
--           To make this table conform to First Normal Form (1NF), each award should be stored as an atomic value. 
--           That means there should be no multi-valued attributes in a single column.



-- Question 2 Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF. 
-- explain the steps to normalize it?
-- Answer 2. The film table from sakila databse violates 2NF. 
--           The special_features column contains multiple values (e.g., "Behind the Scenes, Commentary").
--           This violates 1NF because the values in this column are not atomic—they contain a list of features instead of one feature per field.
--           2NF requires the table to be in 1NF, and since special_features violates 1NF, the table automatically violates 2NF.
--           To bring the film table into 2NF, we need to address both the 1NF violation & partial dependencies.
--           We should create a new table, that stores one special feature per row, establishing a relationship between film_id and special_features.
--           After fixing the 1NF violation, we also need to ensure there are no partial dependencies in the table.
--           We need to create a new table for the special_features and link it to the film table by creating foreign key relationships.



-- Question 3. Identify a table in Sakila that violates 3NF Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
-- Answer 3.  A table is in 3NF if: It is in 2NF. And no transitive dependencies exist, i.e., non-prime attributes should not depend on anything other than the primary key.
--            The customer table violates 3rd Normal Form (3NF)  in the Sakila database. 
--            In the customer table, there is a transitive dependency through the address_id:
--            The address_id determines the customer's city and country. This is a transitive dependency because address_id is dependent on customer_id, 
--            but city and country are dependent on address_id (not customer_id directly).

--            Steps to Normalize the customer Table to 3NF:

--            1. Analyse the violation 
--            2. Create new table to store data 
--            3. Update customer table (make store id as foreign key)
--            4. Update address info. (so it reference to the foreign key)



-- Question 4. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
-- Answer 4. 
--             The film table in this database appears unnormalized. To normalize it up to 2NF, follow these steps:
--             Primary Key: Use film_id as the primary key.
--             Eliminate Repeating Groups: The special_features column violates 1NF with multiple values. Create a separate table for special features.
--             Eliminate Partial Dependencies: Attributes like language_id and original_language_id are partially dependent on film_id. Create a new table for languages and reference it via foreign keys.
--             Check for Transitive Dependencies: No transitive dependencies are present, so the table is now in 2NF.



-- Question 5. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
-- Answer 5.   
WITH ActorFilmCount AS (
    SELECT
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, actor_name)
SELECT
    actor_name,
    film_count
FROM
    ActorFilmCount
ORDER BY
    film_count DESC, actor_name ;
    

    
-- Question 6. Use a recursive CTE to generate a hierarchical list of categories and their subcategories from the category table in Sakila.
-- Answer 6.
WITH RECURSIVE CategoryHierarchy AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        NULL AS parent_category_id,
        0 AS level
    FROM
        category c
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM film_category fc
            WHERE fc.category_id = c.category_id
        )

    UNION ALL

    SELECT
        c.category_id,
        c.name AS category_name,
        fc.category_id AS parent_category_id,
        ch.level + 1 AS level
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        CategoryHierarchy ch ON fc.film_id = ch.category_id
)
SELECT
    category_id,
    category_name,
    parent_category_id,
    level
FROM
    CategoryHierarchy
ORDER BY
    level, category_id ; 
    


-- Question 7. Create a CTE that combines information from the film and language tables to display the films title, language name, rental rate.
-- Answer 7.
WITH FilmLanguageInfo AS (
    SELECT
        f.title AS film_title,
        l.name AS language,
        f.rental_rate
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
)
SELECT
    film_title,
    language,
    rental_rate
FROM
    FilmLanguageInfo;



-- Question 8. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from customer and payment table.
-- Answer 8.

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    LEFT JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, customer_name
)

SELECT
    customer_id,
    customer_name,
    COALESCE(total_revenue, 0) AS total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC;
    
    
    
-- Question 9. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
-- Answer 9.
WITH RankedFilms AS (
    SELECT
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM
        film
)

SELECT
    film_id,
    title,
    rental_duration,
    rental_duration_rank
FROM
    RankedFilms
ORDER BY
    rental_duration_rank;
 
-- Question 10. Create a CTE to list customers who have made more than two rentals, & then join this CTE with the customer table to retrieve additional customer details. 
-- Answer 10
 WITH CustomerRentals AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2
)

SELECT
    c.*,
    cr.rental_count
FROM
    customer c
JOIN
    CustomerRentals cr ON c.customer_id = cr.customer_id
ORDER BY
    cr.rental_count DESC;
    


-- Question 11. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.
-- Answer 11. 
WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        rental_month
)

SELECT
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;
    
    
-- Question 12.Use a CTE to pivot the data from the payment rental_date table to display the total payments made by each customer in separate columns for different payment methods.
-- Answer 12. Since we dont have payment method column or any column that specify payment type we will calculate total payments made by each customer 

WITH CustomerPayments AS (
    SELECT
        customer_id,
        SUM(amount) AS total_payments
    FROM
        payment
    GROUP BY
        customer_id
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cp.total_payments
FROM
    customer c
JOIN
    CustomerPayments cp ON c.customer_id = cp.customer_id;



-- Question 13. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using film_actor the table.
-- Answer 13.
WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        COUNT(*) AS films_together
    FROM
        film_actor fa1
        JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    GROUP BY
        fa1.actor_id, fa2.actor_id
    HAVING
        COUNT(*) > 0
)

SELECT
    ap.actor1_id,
    ap.actor2_id,
    ap.films_together
FROM
    ActorPairs ap;


-- Question 14. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to coulmn.
-- Answer 14. 
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff s
    WHERE 
        s.staff_id = 1

    UNION ALL

    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to
    FROM 
        staff s
    INNER JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)

SELECT 
    staff_id, 
    first_name, 
    last_name, 
    reports_to
FROM 
    EmployeeHierarchy;
    
    
