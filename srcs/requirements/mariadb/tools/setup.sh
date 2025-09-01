#!/bin/bash

# Get passwords from environment variables
ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD"
USER_PASSWORD="$MYSQL_PASSWORD"

# Initialize database if not exists
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    
    # Initialize MySQL database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Start MySQL in background
    mysqld_safe --datadir=/var/lib/mysql &
    
    # Wait for MySQL to start
    while ! mysqladmin ping --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 1
    done
    
    echo "Setting up database and users..."
    
    # Create database and users
    mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`$MYSQL_USER\`@'%' IDENTIFIED BY '$USER_PASSWORD';"
    mysql -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO \`$MYSQL_USER\`@'%';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"
    mysql -e "FLUSH PRIVILEGES;"
    
    # Stop the background MySQL process
    mysqladmin -p"$ROOT_PASSWORD" shutdown
    
    echo "MariaDB initialization completed!"
else
    echo "MariaDB data directory exists, starting server and ensuring database setup..."
    
    # Start MySQL in background
    mysqld_safe --datadir=/var/lib/mysql &
    
    # Wait for MySQL to start
    while ! mysqladmin ping --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 1
    done
    
    # Ensure database and user exist (in case they were missing)
    echo "Ensuring database and user configuration..."
    mysql -u root -p"$ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;" 2>/dev/null || mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
    mysql -u root -p"$ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS \`$MYSQL_USER\`@'%' IDENTIFIED BY '$USER_PASSWORD';" 2>/dev/null || mysql -e "CREATE USER IF NOT EXISTS \`$MYSQL_USER\`@'%' IDENTIFIED BY '$USER_PASSWORD';"
    mysql -u root -p"$ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO \`$MYSQL_USER\`@'%';" 2>/dev/null || mysql -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO \`$MYSQL_USER\`@'%';"
    mysql -u root -p"$ROOT_PASSWORD" -e "FLUSH PRIVILEGES;" 2>/dev/null || mysql -e "FLUSH PRIVILEGES;"
    
    # Stop the background MySQL process
    mysqladmin -p"$ROOT_PASSWORD" shutdown 2>/dev/null || mysqladmin shutdown
    
    echo "Database configuration verified!"
fi

# Start MariaDB in foreground
exec mysqld_safe --datadir=/var/lib/mysql
