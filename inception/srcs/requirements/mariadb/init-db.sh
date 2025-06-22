#!/bin/sh
# Script de inicialización para MariaDB
# Crea la base de datos y usuarios usando secrets y variables de entorno

set -e
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_USER_PASSWORD=$(cat /run/secrets/db_password)

# Crear base de datos y usuario si no existen
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Notas:
# - Usa secrets para las contraseñas.
# - No deja usuarios root sin contraseña.
# - Solo crea lo necesario según el subject.
