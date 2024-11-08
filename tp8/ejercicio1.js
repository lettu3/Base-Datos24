//Ejercicio 1
use('mflix');

/* Cantidad de cines (theaters) por estado.*/


db.theaters.aggregate([
    {
        $group: {
            _id: "$location.address.state",
            count: {$sum : 1}
        }
    },
    {
        $sort: {count : -1}
    }
])
