USE world;

-- Ejercicio 1
SELECT city.Name AS cityName, country.Name AS countryName, country.Region, country.GovernmentForm
FROM city 
INNER JOIN country ON country.Code  = city.CountryCode
ORDER BY country.Population DESC LIMIT 10;

-- Ejercicio 2
SELECT country.Name, city.Name as Capital 
FROM country
LEFT JOIN city ON country.Capital = city.ID 
ORDER BY country.Population ASC LIMIT 10;

-- Ejercicio 3
SELECT country.Name, country.Continent , countrylanguage.`Language`
FROM country
LEFT JOIN countrylanguage ON country.Code = countrylanguage.CountryCode 
AND countrylanguage.IsOfficial = 'T';

-- Ejercicio 4
SELECT country.Name , city.Name
FROM country
LEFT JOIN city ON country.Code = city.CountryCode
AND country.Capital = city.ID 
ORDER BY country.SurfaceArea DESC LIMIT 20;

-- Ejercicio 5
-- 

-- Ejercicio 6
(SELECT country.Name 
FROM country
ORDER BY country.Population DESC LIMIT 10)
UNION
(SELECT country.Name 
FROM country
ORDER BY country.Population ASC LIMIT 10);

-- Ejercicio 7
(
SELECT country.Name
FROM country
LEFT JOIN countrylanguage ON countrylanguage.CountryCode = country.Code
AND countrylanguage.`Language` = 'English' AND countrylanguage.IsOfficial = 'T'
)


-- EJERCICIOS 5 Y 7 INCOMPLETOS
