//Ejercicio 9
use('mflix');

/* Remover todos los comentarios realizados por el usuario cuyo email es
   victor_patel@fakegmail.com durante el año 1980.
*/


db.comments.deleteMany(
    {
        email: "victor_patel@fakegmail.com",
        date: {
            $gte: new Date("1980-1-1"),
            $lt: new Date("1981-1-1")
        }
    }
);

