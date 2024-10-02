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

-- Ejercicio 5
-- con subquery
SELECT country.Region FROM country
WHERE country.SurfaceArea < 1000 
AND country.Code IN (
	SELECT city.CountryCode
	FROM city
	WHERE city.Population > 100000
);


-- sin subquery
SELECT country.Region FROM country
INNER JOIN city ON city.CountryCode = country.Code
WHERE country.SurfaceArea < 1000 AND city.Population > 100000;


-- Ejercicio 6
-- con consulta escalar 
SELECT country.Name, city.Population FROM country
INNER JOIN city ON city.CountryCode = country.Code
WHERE city.population = (
	SELECT max(city.Population)
	FROM city 
	WHERE city.CountryCode = country.Code
);

-- con agregacion (MAX)
SELECT country.Name, MAX(city.Population) FROM country
INNER JOIN city ON city.CountryCode = country.Code
GROUP BY country.Name;


-- Ejercicio 7
select country.Name, countrylanguage.language
from country
inner join countrylanguage on country.Code = countrylanguage.CountryCode
where countrylanguage.Percentage > (
	select avg(countrylanguage.Percentage)
	from countrylanguage
	where countrylanguage.CountryCode = country.Code and countrylanguage.IsOfficial = 'T'
);

-- Ejercicio 8
select continent.Name, sum(country.Population) as TotalPopulation
from continent
inner join country on country.Continent = continent.Name
group by continent.Name
order by TotalPopulation desc;


-- Ejercicio 9
select continent.Name, avg(country.LifeExpectancy) as LifeExpectancy
from continent
inner join country on country.Continent = continent.Name
where LifeExpectancy > 40 and LifeExpectancy < 70
group by continent.Name

	
-- Ejercicio 10

select continent.Name,
		max(country.Population) as MaxPopulation,
		min(country.Population) as MinPopulation,
		avg(country.Population) as AvgPopulation,
		sum(country.Population) as TotalPopulation
from continent
inner join country on continent.Name = country.Continent
group by continent.Name;


-- Parte 2
-- Si en la consulta 6 se quisiera devolver, además de las columnas ya solicitadas,
-- el nombre de la ciudad más poblada. ¿Podría lograrse con agrupaciones? ¿y con una subquery escalar?

-- Rta: si
-- con agregacion + subquery
SELECT country.Name AS CountryName, city.Name AS CityName, city.Population FROM country
INNER JOIN city ON city.CountryCode = country.Code
INNER JOIN (
	SELECT CountryCode, max(Population) AS MaxPopulation
	FROMS city
	GROUP BY CountryCode
) AS max_city ON city.CountryCode = max_city.CountryCode AND city.Population = max_city.MaxPopulation;


-- con consulta escalar
SELECT country.Name,
	    (
		SELECT city.Name
		FROM city
		WHERE city.CountryCode = country.Code
		ORDER BY city.Population DESC 
		LIMIT 1
		) AS MostPopulousCity,
		(
		SELECT city.Population
		FROM city
		WHERE city.CountryCode = country.Code
		ORDER BY city.Population DESC 
		LIMIT 1
		)
FROM country;
