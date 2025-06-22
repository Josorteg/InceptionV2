#!/bin/sh
# Script de inicialización para WordPress
# Crea usuarios y configura WordPress usando variables de entorno y secrets

set -ex

# Cargar secrets
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Esperar a que la base de datos esté lista
until mysqladmin ping -h "$MARIADB_HOST" --silent; do
    echo 'Esperando a MariaDB...'
    sleep 2
done

# Instalar WordPress si no está instalado
if ! wp core is-installed --allow-root; then
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=author --allow-root
fi

exec php-fpm81 --nodaemonize
# Notas:
# - Usa secrets para las contraseñas.
# - No crea usuarios "admin".
# - Permite personalizar todo desde .env y secrets.
