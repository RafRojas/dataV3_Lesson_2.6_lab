USE sakila; 

-- 1) In the table actor, which are the actors whose last names are not repeated? --

SELECT last_name AS 'Non repeated last names' FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;

-- 2) Which last names appear more than once? --

SELECT last_name AS 'Last names repeated more than once' FROM actor 
GROUP BY last_name 
HAVING COUNT(*) = 1;

-- 3) Using the rental table, find out how many rentals were processed by each employee. -- 

SELECT COUNT(staff_id) AS 'Rentals from Hillyer' FROM rental
WHERE (staff_id = '1');

SELECT COUNT(staff_id) AS 'Rentals from Stephens' FROM rental
WHERE (staff_id = '2');

-- 4) Using the film table, find out how many films were released each year. -- 

SELECT DISTINCT(COUNT(release_year)) AS 'Movies released in 2006' FROM film
GROUP BY release_year;

-- 5) Using the film table, find out for each rating how many films were there. --

SELECT DISTINCT rating FROM film;

SELECT COUNT(rating) as 'Number of PG films' FROM film 
WHERE rating = 'PG';
SELECT COUNT(rating) as 'Number of G films' FROM film 
WHERE rating = 'G';
SELECT COUNT(rating) as 'Number of NC-17 films' FROM film 
WHERE rating = 'NC-17';
SELECT COUNT(rating) as 'Number of PG-13 films' FROM film 
WHERE rating = 'PG-13';
SELECT COUNT(rating) as 'Number of R films' FROM film 
WHERE rating = 'R';

-- 6) What is the mean length of the film for each rating type. Round off the average lengths to two decimal places.

SELECT rating AS 'Rating', AVG(length) AS 'Average Length' FROM film
GROUP BY rating;

-- 7)Which kind of movies (rating) have a mean duration of more than two hours? --

SELECT rating AS 'Rating', AVG(length) AS Mean_duration FROM film
GROUP BY rating
HAVING Mean_duration >= 120;

-- 8) Rank films by length (filter out the rows that have nulls or 0s in length column). --

CREATE TEMPORARY TABLE Temp_Film AS SELECT * FROM film;
ALTER TABLE Temp_Film DROP COLUMN original_language_id;
SELECT * FROM Temp_Film; 

SELECT title AS 'Film Title', length AS 'Film Length', row_number() OVER (ORDER BY length) AS 'Row Ranking' FROM Temp_Film;
