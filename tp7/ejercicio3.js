//Ejercicio 3
use('mflix');

/* Listar el nombre, email, texto y fecha de los comentarios que la película
   con id (movie_id) ObjectId("573a1399f29313caabcee886") recibió entre los
   años 2014 y 2016 inclusive. Listar ordenados por fecha. Escribir una nueva
   consulta (modificando la anterior) para responder ¿Cuántos comentarios recibió?
*/

db.comments.find(
    {
        movie_id : ObjectId("573a1399f29313caabcee886"),
        date : {$gte: new Date("2014-01-01"), $lte: new Date("2016-12-31")}
    },
    {
        name: 1,
        email: 1,
        text: 1,
        date: 1
    }
).sort({date: 1}) // para que se ordenen cronologicamente


//consulta nueva, para saber cuantos comentarios recibio la pelicula
db.comments.countDocuments(
    {
        movie_id: ObjectId("573a1399f29313caabcee886"),
        date : {$gte: new Date("2014-01-01"), $lte: new Date("2016-12-31")}
    }
)
