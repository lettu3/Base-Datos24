//Ejercicio 8
use('mflix');

/* Actualizar el valor de la contraseña del usuario cuyo email
   es joel.macdonel@fakegmail.com a "some password". La misma consulta debe
   poder insertar un nuevo usuario en caso que el usuario no exista. Ejecute
   la consulta dos veces. ¿Qué operación se realiza en cada caso?
   (Hint: usar upserts). 
*/


db.users.updateOne(
    {
        email: "joel.macdonel@fakegmail.com"
    },
    {
        $set : {
            password: "some password"
        }
    },
    {upsert: true}
)
