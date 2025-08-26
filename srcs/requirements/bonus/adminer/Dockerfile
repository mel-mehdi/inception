FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    nginx \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download Adminer
RUN mkdir -p /var/www/html
RUN wget -O /var/www/html/index.php https://www.adminer.org/latest.php

# Copy configuration
COPY tools/nginx.conf /etc/nginx/nginx.conf
COPY tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /run/php

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
