# Dockerfile para MariaDB
# Imagen base oficial de MariaDB, personalizando la inicialización
FROM mariadb:11.3.2

# Copia de scripts de inicialización
COPY ./init-db.sh /docker-entrypoint-initdb.d/init-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

# Notas de seguridad y subject:
# - No se usan contraseñas ni usuarios por defecto.
# - El script init-db.sh debe crear la base de datos y usuarios usando secrets.
# - Se recomienda no exponer el puerto 3306 fuera de la red interna de Docker.
