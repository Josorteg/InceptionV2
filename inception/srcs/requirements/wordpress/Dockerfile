# Dockerfile para WordPress (cumpliendo subject 42: solo Alpine/Debian como base)
FROM alpine:3.19

# Instalar dependencias necesarias: PHP, php-fpm, extensiones y utilidades mínimas
RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-curl \
    php81-xml \
    php81-gd \
    php81-mbstring \
    php81-zip \
    php81-opcache \
    php81-dom \
    php81-tokenizer \
    php81-session \
    php81-ctype \
    php81-exif \
    php81-ftp \
    php81-soap \
    php81-bcmath \
    php81-pdo \
    php81-pdo_mysql \
    php81-openssl \
    php81-phar \
    php81-posix \
    php81-simplexml \
    php81-fileinfo \
    curl \
    wget \
    tar \
    unzip \
    mysql-client

# Crear usuario y grupo www-data (compatibilidad WordPress)
RUN addgroup -g 82 -S www-data && adduser -u 82 -D -S -G www-data www-data

# Descargar y descomprimir WordPress
ENV WORDPRESS_VERSION=6.5.4
RUN wget https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
    && tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz -C /var/www/ \
    && rm wordpress-${WORDPRESS_VERSION}.tar.gz \
    && chown -R www-data:www-data /var/www/wordpress

# Copiar configuración personalizada y scripts
COPY ./wp-init.sh /usr/local/bin/wp-init.sh
RUN chmod +x /usr/local/bin/wp-init.sh

WORKDIR /var/www/wordpress

# Entrypoint personalizado para inicializar WordPress con variables y secrets
ENTRYPOINT ["/usr/local/bin/wp-init.sh"]

# Exponer el puerto de php-fpm
EXPOSE 9000

# Notas de seguridad y subject:
# - No se usan credenciales por defecto ni usuarios "admin".
# - Se recomienda usar secrets y variables de entorno para todo lo sensible.
# - El script wp-init.sh debe crear los usuarios y configuraciones según el subject.
# - Cumple el subject: solo Alpine como base, todo instalado manualmente.
