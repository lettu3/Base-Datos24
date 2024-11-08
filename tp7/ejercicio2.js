//Ejercicio 2
use('mflix');

/* Listar el título, año, actores (cast), directores y rating de las 10 
   películas con mayor rating (“imdb.rating”) de la década del 90. ¿Cuál es el
   valor del rating de la película que tiene mayor rating? (Hint: Chequear que
   el valor de “imdb.rating” sea de tipo “double”).
*/

db.movies.find(
    {
        //filtro por year $gte = greater than..., $lte less than...
        year: {$gte:1990, $lte:1999},
        //me aseguro que el imdb rating sea double
        "imdb.rating": {$type : "double"}
    },
    {
        //devuelvo titulo, año, actores (cast), directores y rating
        title: 1,
        year: 1,
        cast: 1,
        directors: 1,
        "imdb.rating": 1
    }
).sort({"imdb.rating": -1}).limit(10); //sort ({campo : -1}) es orden descendente
