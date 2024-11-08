//Ejercicio 10
use('restaurantdb');

/* Listar el id del restaurante (restaurant_id) y las calificaciones de los
   restaurantes donde al menos una de sus calificaciones haya sido realizada
   entre 2014 y 2015 inclusive, y que tenga una puntuación (score) mayor a 70
   y menor o igual a 90.

*/


db.restaurants.find(
    {
        "grades.date": {$gte: new Date("2014-1-1"), $lt: new Date("2016-1-1")},
        "grades.score": {$gt: 70, $lte: 90}
    },
    {
        restaurant_id: 1,
        grades: 1
    }
);
