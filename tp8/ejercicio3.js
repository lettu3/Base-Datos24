//Ejercicio 3
use('mflix');

/* Cantidad de películas dirigidas por "Louis Lumière". Se puede responder sin
  pipeline de agregación,   realizar ambas queries.
*/


//sin pipeline
db.movies.countDocuments({directors: "Louis Lumière"});

//con pipeline
db.movies.aggregate([
    {
        $match: {
            directors: "Louis Lumière"
        }
    },
    {
        $count: "movies_directed_by_louis_lumiere"
    }
])
