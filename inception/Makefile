# Makefile base para Inception

NAME=inception
# Variable que define el comando base para docker-compose, usando el archivo y entorno correctos
COMPOSE=docker-compose -f srcs/docker-compose.yml --env-file srcs/.env
LOGIN=josorteg
# PHONY evita conflictos si existen archivos con el mismo nombre que los comandos
.PHONY: all build up down clean fclean re

# all: Construye y levanta todos los servicios (por defecto)
all: build up

# build: Construye las imágenes de los servicios definidos en docker-compose.yml
build:
	$(COMPOSE) build

# up: Levanta los servicios en segundo plano (detached)
up: init_dirs
	$(COMPOSE) up -d

# down: Detiene y elimina los contenedores, pero mantiene los volúmenes
down:
	$(COMPOSE) down

# clean: Detiene y elimina los contenedores, volúmenes y orphans
clean:
	$(COMPOSE) down -v --remove-orphans

# fclean: Ejecuta clean y además elimina todas las imágenes, volúmenes y cachés no usados
fclean: clean
	docker system prune -af

# re: Fuerza una limpieza total y vuelve a construir y levantar todo
re: fclean all


init_dirs:
	mkdir -p /home/$(LOGIN)/data/wp_data
	mkdir -p /home/$(LOGIN)/data/db_data
	chmod 755 /home/$(LOGIN)/data/wp_data
	chmod 755 /home/$(LOGIN)/data/db_data
# Resumen de comandos docker y docker-compose usados en el Makefile

# docker-compose build
#   Construye las imágenes de los servicios definidos en docker-compose.yml.
#   Opciones útiles:
#     --no-cache     Fuerza a no usar la cache de capas.
#     --pull         Intenta actualizar las imágenes base.

# docker-compose up -d
#   Levanta los servicios en segundo plano (detached).
#   Opciones útiles:
#     --build        Fuerza a construir antes de levantar.
#     --force-recreate  Recrea los contenedores aunque no haya cambios.

# docker-compose down
#   Detiene y elimina los contenedores, pero mantiene los volúmenes.
#   Opciones útiles:
#     -v             Elimina también los volúmenes asociados.
#     --remove-orphans  Elimina contenedores huérfanos (no definidos en el compose actual).

# docker system prune -af
#   Elimina TODO lo que no esté en uso: imágenes, contenedores, volúmenes y redes.
#   Opciones:
#     -a             Elimina todas las imágenes no usadas (no solo las "dangling").
#     -f             Forzar sin pedir confirmación.

# Otros comandos útiles:
# docker-compose logs [servicio]   # Ver logs de un servicio
# docker-compose exec [servicio] bash  # Entrar en un contenedor en ejecución
# docker-compose ps                # Ver el estado de los servicios

# Puedes añadir más comandos según necesidades
