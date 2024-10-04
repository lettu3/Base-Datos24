USE sakila;

-- Ejercicio 1
-- Cree una tabla de `directors` con las columnas: Nombre, Apellido, Número de Películas.
CREATE TABLE directors (
	Name char(64) NOT NULL DEFAULT '',
	Surname char(64) NOT NULL DEFAULT '',
	NumberOfMovies int,
	PRIMARY KEY(Name, Surname)
);

-- Ejercicio 2
-- El top 5 de actrices y actores de la tabla `actors` que tienen la mayor experiencia
-- (i.e. el mayor número de películas filmadas) son también directores de las películas en las que participaron.
-- Basados en esta información, inserten, utilizando una subquery los valores correspondientes en la tabla `directors`.
INSERT INTO directors (Name, Surname, NumberOfMovies)
SELECT actor.first_name AS Name, actor.last_name AS Surname, COUNT(film_actor.film_id) AS NumberOfMovies
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id 
GROUP BY actor.first_name, actor.last_name, actor.actor_id
ORDER BY NumberOfMovies DESC LIMIT 5;
-- necesitamos hacer group by actor_id para evitar errores en caso de que actores tengan el mismo nombre


-- Ejercicio 3
-- Agregue una columna `premium_customer` que tendrá un valor 'T' o 'F' de acuerdo a si el cliente es "premium" o no.
-- Por defecto ningún cliente será premium.
ALTER TABLE customer
ADD COLUMN premium_customer ENUM('T','F') NOT NULL DEFAULT 'F';


-- Ejercicio 4
-- Modifique la tabla customer. Marque con 'T' en la columna `premium_customer`
-- de los 10 clientes con mayor dinero gastado en la plataforma.

UPDATE customer
SET premium_customer = 'T'
WHERE customer_id IN (
    SELECT customer_id
    FROM (
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        ORDER BY SUM(amount) DESC
        LIMIT 10
    ) AS top_customers
);

-- Ejercicio 5
-- Listar, ordenados por cantidad de películas (de mayor a menor),
-- los distintos ratings de las películas existentes
-- (Hint: rating se refiere en este caso a la clasificación según edad: G, PG, R, etc).
SELECT rating, COUNT(film.rating) AS HowMany 
FROM film
GROUP BY film.rating
ORDER BY COUNT(film.rating) DESC;

-- Ejercicio 6
-- ¿Cuáles fueron la primera y última fecha donde hubo pagos?
SELECT MIN(payment.payment_date) AS first_payment, MAX(payment.payment_date) AS last_payment
FROM payment;

-- Ejercicio 7
-- Calcule, por cada mes, el promedio de pagos (Hint: vea la manera de extraer el nombre del mes de una fecha).
SELECT AVG(amount) AS AveragePayment, MONTH(payment.payment_date) AS MonthOfPay
FROM payment
GROUP BY MonthOfPay;

-- Ejercicio 8
-- Listar los 10 distritos que tuvieron mayor cantidad de alquileres (con la cantidad total de alquileres).
SELECT address.district, COUNT(rental.rental_id) AS TotalRents
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN address ON address.address_id = customer.address_id
GROUP BY address.district
ORDER BY TotalRents DESC
LIMIT 10;


-- Ejercicio 9
-- Modifique la table `inventory_id` agregando una columna `stock` que sea un número entero y representa
-- la cantidad de copias de una misma película que tiene determinada tienda.
-- El número por defecto debería ser 5 copias.
ALTER TABLE inventory
ADD COLUMN stock int NOT NULL DEFAULT 5;


-- Ejercicio 10
-- Cree un trigger `update_stock` que, cada vez que se agregue un nuevo registro a la tabla rental,
-- haga un update en la tabla `inventory` restando una copia al stock de la película rentada
-- (Hint: revisar que el rental no tiene información directa sobre la tienda,
-- sino sobre el cliente, que está asociado a una tienda en particular).
DROP TRIGGER IF EXISTS update_stock;

CREATE TRIGGER update_stock AFTER INSERT
ON rental FOR EACH ROW
BEGIN 
	UPDATE inventory
	SET inventory.stock = inventory.stock - 1
	WHERE inventory.inventory_id = new.inventory_id AND inventory.stock > 0;
END;


-- Ejercicio 11
-- Cree una tabla `fines` que tenga dos campos: `rental_id` y `amount`.
-- El primero es una clave foránea a la tabla rental y el segundo es un valor numérico con dos decimales.

CREATE TABLE fines (
	rental_id int,
	amount decimal(10,2),
	CONSTRAINT fk_rental FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);


-- Ejercicio 12
-- Cree un procedimiento `check_date_and_fine` que revise la tabla `rental` y cree un registro
-- en la tabla `fines` por cada `rental` cuya devolución (return_date) haya tardado más de 3 días
-- (comparación con rental_date). El valor de la multa será el número de días de retraso multiplicado por 1.5.

DROP PROCEDURE IF EXISTS check_date_and_fine;

CREATE PROCEDURE check_date_and_fine ()
BEGIN
	INSERT INTO fines (rental_id, amount)
	SELECT rental.rental_id,
	(datediff(rental.return_date, rental.rental_date) * 1.5) AS amount
	FROM rental
	WHERE datediff(rental.return_date, rental.rental_date) > 3;
END;


-- Ejercicio 13
-- Crear un rol `employee` que tenga acceso de inserción, eliminación y actualización a la tabla `rental`.
CREATE ROLE employee;
GRANT INSERT, DELETE, UPDATE ON rental
TO employee;


-- Ejercicio 14
-- Revocar el acceso de eliminación a `employee` y crear un rol `administrator`
-- que tenga todos los privilegios sobre la BD `sakila`.
REVOKE DELETE
ON rental
FROM employee;

CREATE ROLE administrator;
GRANT ALL PRIVILEGES 
ON sakila.*
TO administrator;


-- Ejercicio 15
-- Crear dos roles de empleado. A uno asignarle los permisos de `employee` y al otro de `administrator`.
CREATE ROLE employee1, employee2;
GRANT employee TO employee1;
GRANT administrator TO employee2;

