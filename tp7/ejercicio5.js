//Ejercicio 5
use('mflix');

/* Listar el título, idiomas (languages), géneros, fecha de lanzamiento (released)
   y número de votos (“imdb.votes”) de las películas de géneros Drama y
   Action (la película puede tener otros géneros adicionales), que solo están
   disponibles en un único idioma y por último tengan un rating (“imdb.rating”)
   mayor a 9 o bien tengan una duración (runtime) de al menos 180 minutos.
   Listar ordenados por fecha de lanzamiento y número de votos.
*/

db.movies.find(
    {
        genres: {$in: ["Drama", "Action"]},
        languages: {$size: 1},
        $or : [
            {"imdb.rating" : {$gte: 9}},
            {"runtime": {$gte: 180}}
        ]
    },
    {
        name: 1,
        languages: 1,
        genres: 1,
        released: 1,
        "imdb.votes": 1
    }
).sort({released: -1, "imdb.votes": -1})
