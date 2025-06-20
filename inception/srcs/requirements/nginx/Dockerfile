# Dockerfile para NGINX
# Imagen base oficial de Alpine para ligereza y seguridad
FROM alpine:3.19

# Instalación de NGINX y utilidades necesarias
RUN apk update && apk add --no-cache nginx openssl

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
