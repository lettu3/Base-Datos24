USE world;


-- Ejercicio 1
SELECT city.Name, country.Name
FROM city
INNER JOIN country ON country.Code = city.CountryCode
WHERE country.Population < 10000;

-- Ejercicio 2
SELECT city.Name as cityName
FROM city
WHERE city.Population > (SELECT AVG(Population) FROM city);

-- Ejercicio 3
-- selecciono todas las ciudades que no son asiaticas
SELECT city.Name
FROM city
INNER JOIN country ON country.Code = city.CountryCode AND country.Continent != 'Asia'
-- donde su poblacion es mayor a la de algun pais asiatico
WHERE city.Population >=  SOME (SELECT Population FROM country WHERE Continent = 'Asia');

-- Ejercicio 4
SELECT country.Name AS Name, countrylanguage.Language AS Language
FROM country
INNER JOIN countrylanguage ON countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'F'
WHERE countrylanguage.Percentage > (SELECT MAX(Percentage)
								    FROM countrylanguage
								    WHERE countrylanguage.CountryCode = country.Code
								    AND countrylanguage.IsOfficial = 'T');


