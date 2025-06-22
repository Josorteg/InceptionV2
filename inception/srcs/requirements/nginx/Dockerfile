# Dockerfile para NGINX
# Imagen base oficial de Alpine para ligereza y seguridad
FROM alpine:3.19

# Instalación de NGINX y utilidades necesarias
RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/ssl/certs /etc/ssl/private \
 && openssl req -x509 -nodes -days 365 \
   -newkey rsa:2048 \
   -keyout /etc/ssl/private/nginx.key \
   -out /etc/ssl/certs/nginx.crt \
   -subj "/C=ES/ST=42/L=Campus/O=42/OU=Inception/CN=localhost"
# Copia del archivo de configuración personalizado
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 443 para HTTPS
EXPOSE 443

# Comando por defecto
CMD ["nginx", "-g", "daemon off;"]

# Notas de seguridad y subject:
# - Se usa Alpine por ser ligera y tener menos superficie de ataque.
# - Solo se instala lo necesario.
# - El archivo nginx.conf debe estar adaptado a los requisitos del subject (SSL, redirecciones, etc.).
