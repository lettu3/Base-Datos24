#!/bin/bash

#pullear la imagen mas reciente de mongo
docker pull mongo

#correr el contenedor, con nombre $NAME, y directorio host $DIRECTORY, en el puerto 27017
docker run -d --name $(NAME) -p 27017:27017 -v $(DIRECTORY):/data/db mongo:latest

#verificacion de que efectivamente el contenedor esta corriendo
docker ps

#printea la ip en la que esta corriendo el contenedor
docker inspect -f "{{ .NetworkSettings.IPAddress }}" $(NAME)

#para poder copiar archivos dentro del contenedor
docker cp $(FILE_TO_COPY) $(NAME):$(ROUTE_IN_CONTAINER)

#para poder realizar comandos desde el contenedor
docker exec -it $(NAME) $(COMMAND)
