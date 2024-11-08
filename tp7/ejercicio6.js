//Ejercicio 6
use('mflix');

/* Listar el id del teatro (theaterId), estado (“location.address.state”),
   ciudad (“location.address.city”), y coordenadas (“location.geo.coordinates”)
   de los teatros que se encuentran en algunos de los estados "CA", "NY", "TX"
   y el nombre de la ciudades comienza con una ‘F’. Listar ordenados por estado y ciudad.
*/

db.theaters.find(
    {
        "location.address.state" : {$in: ["CA", "NY", "TX"]},
        "location.address.city" : {$regex: "^F", $options: "i"} //options i no distingue entre mayus o minus
    },
    {
        _id: 1,
        "location.address.state": 1,
        "location.address.city" : 1,
        "location.geo.coordinates": 1
    }
).sort({"location.address.state": 1, "location:address.city": 1});
