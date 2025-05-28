# Imagen base
FROM debian:bullseye


# Instala dependencias necesarias: Apache, curl, Node.js, npm
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    gnupg \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @angular/cli \
    && apt-get clean

# Configura Apache para servir archivos desde /var/www/html
COPY apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Crea carpeta de app
RUN mkdir -p /var/www/html

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en foreground
CMD ["apachectl", "-D", "FOREGROUND"]
