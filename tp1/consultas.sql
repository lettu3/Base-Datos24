USE world;

-- Ejercicio 1
SELECT Name, Region FROM country
ORDER BY Region ASC, Name ASC;

-- Ejercicio 2
SELECT Name, Population FROM country
ORDER BY Population DESC LIMIT 10;

-- Ejercicio 3
SELECT Name, Region, SurfaceArea, GovernmentForm FROM country
ORDER BY SurfaceArea ASC LIMIT 10;

-- Ejercicio 4
SELECT Name FROM country
WHERE IndepYear IS NULL;

-- Ejercicio 5
SELECT Language, Percentage FROM countrylanguage
WHERE isOfficial = 'T'; 