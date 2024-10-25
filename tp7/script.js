/*PARTE I*/
/*EJERCICIO 1*/
use mflix;

const users = [
    {name: "user1", email:"user1@mail.com"},
    {name: "user2", email:"user2@mail.com"},
    {name: "user3", email:"user3@mail.com"},
    {name: "user4", email:"user4@mail.com"},
    {name: "user5", email:"user5@mail.com"},
];

// Solo insertalos si no existen
users.forEach(user => {
    if (!db.users.findOne({ email: user.email })) {
        db.users.insertOne(user);
    } else {
        print("User with email " + user.email + " already exists, skipping insertion.");
    }
});

const comments = [
    {user_id: db.users.findOne({email: "user1@mail.com"})._id, movie_id: "1", comment: "prendo el velador POM cortocircuito, cazo la moto tranqui FU FU FU..."},
    {user_id: db.users.findOne({email: "user2@mail.com"})._id, movie_id: "1", comment: "buena pelicula, no me gusto que el protagonista sea N"},
    {user_id: db.users.findOne({email: "user3@mail.com"})._id, movie_id: "2", comment: "PESIMA, encima en una parte entra uno y le saca las merengadas al prota"},
    {user_id: db.users.findOne({email: "user4@mail.com"})._id, movie_id: "2", comment: "ta buena"},
    {user_id: db.users.findOne({email: "user5@mail.com"})._id, movie_id: "3", comment: "lol"},
];

// debugging con print
comments.forEach(comment => {
    print("Inserting comment for user_id: " + comment.user_id);
    db.comments.insertOne(comment);
});

//no se si esta mal escrito pero no esta andando loco
