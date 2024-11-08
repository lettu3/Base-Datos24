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

