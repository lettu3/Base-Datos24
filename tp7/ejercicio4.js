//Ejercicio 4
use('mflix');

/* Listar el nombre, id de la película, texto y fecha de los 3 comentarios más
   recientes realizados por el usuario con email patricia_good@fakegmail.com. 
*/

db.comments.find(
    {
        email: "patricia_good@fakegmail.com"
    },
    {
        name: 1,
        movie_id: 1,
        text: 1,
        date: 1
    }
).sort({date: -1}).limit(3)
