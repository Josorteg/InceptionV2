# Dockerfile para WordPress
# Imagen base oficial de WordPress, pero personalizando la configuración y evitando credenciales hardcodeadas
FROM wordpress:6.5-php8.3-fpm-alpine

# Copia de scripts de inicialización y configuración personalizada
COPY ./wp-init.sh /usr/local/bin/wp-init.sh
RUN chmod +x /usr/local/bin/wp-init.sh

# Entrypoint personalizado para inicializar WordPress con variables y secrets
ENTRYPOINT ["/usr/local/bin/wp-init.sh"]

# Notas de seguridad y subject:
# - No se usan credenciales por defecto ni usuarios "admin".
# - Se recomienda usar secrets y variables de entorno para todo lo sensible.
# - El script wp-init.sh debe crear los usuarios y configuraciones según el subject.
