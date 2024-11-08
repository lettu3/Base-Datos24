//Ejercicio 1
use('mflix');

//inserta los usuarios
db.users.insertMany([
    {name: "user1", email: "user1@gmail.com"},
    {name: "user2", email: "user2@gmail.com"},
    {name: "user3", email: "user3@gmail.com"},
    {name: "user4", email: "user4@gmail.com"},
    {name: "user5", email: "user5@gmail.com"},
]);

//inserta los comentarios
db.comments.insertMany([
    {name: "user1" , email: "user1@gmail.com", movie_id: ObjectId('573a1390f29313caabcd418c'), text: "prendo el velador POM cortocircuito, cazo la moto tranqui FU FU FU..." , date: new Date()},
    {name: "user2" , email: "user2@gmail.com", movie_id: ObjectId('573a1390f29313caabcd418c'), text: "buena pelicula, no me gusto que el protagonista sea N" , date: new Date()},
    {name: "user3" , email: "user3@gmail.com", movie_id: ObjectId('573a1390f29313caabcd418c'), text: "PESIMA, encima en una parte entra uno y le saca las merengadas al prota" , date: new Date()},
    {name: "user4" , email: "user4@gmail.com", movie_id: ObjectId('573a1390f29313caabcd418c'), text: "ta buena" , date: new Date()},
    {name: "user5" , email: "user5@gmail.com", movie_id: ObjectId('573a1390f29313caabcd418c'), text: "lol" , date: new Date()},
]);

//para ver que los resultados se han insertado correctamente
//db.users.find().sort({ _id: -1 }).limit(5).pretty();
//db.comments.find().sort({ _id: -1 }).limit(5).pretty();

