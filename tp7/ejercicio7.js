//Ejercicio 7
use('mflix');

/* Actualizar los valores de los campos texto (text) y fecha (date) del
   comentario cuyo id es ObjectId("5b72236520a3277c015b3b73") a
   "mi mejor comentario" y fecha actual respectivamente.
*/

db.comments.updateOne(
    {
        _id: ObjectId("5b72236520a3277c015b3b73")
    },
    {
        $set : {
            text: "mi mejor comentario",
            date: new Date() 
        }
    }
);
