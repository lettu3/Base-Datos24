#!/bin/bash

# Pullear la imagen mas reciente de mongo
docker pull mongo

# Correr el contenedor, con nombre $NAME, y directorio host $DIRECTORY, en el puerto 27017
docker run -d --name $(NAME) -p 27017:27017 -v $(DIRECTORY):/data/db mongo:latest

# Verificacion de que efectivamente el contenedor esta corriendo
docker ps

# Printea la ip en la que esta corriendo el contenedor
docker inspect -f "{{ .NetworkSettings.IPAddress }}" $(NAME)

# Para poder copiar archivos dentro del contenedor
docker cp $(FILE_TO_COPY) $(NAME):$(ROUTE_IN_CONTAINER)

# Para poder realizar comandos desde el contenedor
docker exec -it $(NAME) $(COMMAND)

# Para poder conectarse desde la extension de VSCode mongodb://127.0.0.1:27017/$(NAME)


#para restaurar una base de datos a partir de bson comprimidos
docker exec -it <nombre_del_contenedor> mongorestore --drop --gzip --db <db_name> <ruta_dentro_del_contenedor>

#para importar una base de datos a partir de un json
docker exec -it <nombre_del_contenedor> mongoimport --db <db_name> --file /<ruta_dentro_del_contenedor
