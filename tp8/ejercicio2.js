//Ejercicio 2
use('mflix');

/* Cantidad de estados con al menos dos cines (theaters) registrados */

db.theaters.aggregate([
    {
        //agrupamos por estado y contamos su cantidad de teatros
        $group: {
            _id: "$location.address.state",
            count: {$sum : 1}
        }
    },
    // matcheamos con los que tengan count >= 2
    {
        $match: {
            count: {$gte: 2}
        }
    },
    //contamos y devolvemos un json
    {
        $count: "states_with_at_least_two_theaters"
    }
])
