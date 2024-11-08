//Ejercicio 4
use('mflix');

/* Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959).
   Se puede responder sin pipeline de agregación, realizar ambas queries.
*/

//sin pipeline
db.movies.countDocuments({year: {$gte: 1950, $lte: 1959}});

//con pipeline
db.movies.aggregate([
    {
        $match: {year: {$gte: 1950, $lte: 1959}}
    },
    {
        $count: "movies_between_1950_and_1959"
    }
]);
