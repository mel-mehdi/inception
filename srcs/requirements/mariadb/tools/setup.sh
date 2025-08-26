#!/bin/bash

# Get passwords from secrets
ROOT_PASSWORD=$(cat $MYSQL_ROOT_PASSWORD_FILE)
USER_PASSWORD=$(cat $MYSQL_PASSWORD_FILE)

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
fi

# Start MariaDB in foreground
exec mysqld_safe --datadir=/var/lib/mysql
