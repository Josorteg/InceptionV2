#!/bin/sh
set -ex

# Exportar automáticamente variables leídas
set -a
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
set +a

# Exportar también usuario y base si hiciera falta (opcional)
MYSQL_USER="${MYSQL_USER:-josorteg_2357}"
MYSQL_DATABASE="${MYSQL_DATABASE:-wordpress}"

echo "Usando base de datos: $MYSQL_DATABASE"
echo "Usuario de base de datos: $MYSQL_USER"
echo "Host base de datos: $MARIADB_HOST"

# Esperar a que la base de datos esté lista
until mysqladmin ping -h "$MARIADB_HOST" --silent; do
    echo 'Esperando a MariaDB...'
    sleep 2
done

# Crea wp-config.php si no existe
if [ ! -f /var/www/html/wp-config.php ]; then
  wp config create \
    --path=/var/www/html \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$MARIADB_HOST" \
    --allow-root
fi

# Instalar WordPress si no está instalado
if ! wp core is-installed --allow-root; then
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
    wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=author --allow-root
fi

exec php-fpm81 --nodaemonize
