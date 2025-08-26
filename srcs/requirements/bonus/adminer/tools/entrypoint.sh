#!/bin/bash

# Start PHP-FPM in background
php-fpm7.4 --daemonize

# Give PHP-FPM time to start
sleep 2

# Start nginx in foreground
nginx -g "daemon off;"
