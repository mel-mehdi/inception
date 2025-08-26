#!/bin/bash

# Get database password from secrets first
DB_PASSWORD=$(cat $WORDPRESS_DB_PASSWORD_FILE)

# Wait for MariaDB to be ready
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"
DB_PASSWORD=$(cat $WORDPRESS_DB_PASSWORD_FILE)

# Change to WordPress directory
cd /var/www/html

# Download WordPress if not already present
if [ ! -f wp-config.php ]; then
    echo "Setting up WordPress..."
    
    # Download WordPress
    wp core download --allow-root
    
    # Create wp-config.php
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root
    
    # Install WordPress
    wp core install \
        --url="https://$DOMAIN_NAME" \
        --title="Inception WordPress" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    # Create additional user
    wp user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
    
    # Install and configure Redis plugin
    if [ ! -z "$REDIS_HOST" ]; then
        wp plugin install redis-cache --activate --allow-root
        
        # Configure Redis
        wp config set WP_REDIS_HOST "$REDIS_HOST" --allow-root
        wp config set WP_REDIS_PORT 6379 --allow-root
        wp config set WP_REDIS_PASSWORD "$REDIS_PASSWORD" --allow-root
        wp config set WP_REDIS_DATABASE 0 --allow-root
        
        # Enable Redis cache
        wp redis enable --allow-root
    fi
    
    echo "WordPress setup completed!"
fi

# Set proper permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Start PHP-FPM
php-fpm7.4 -F
