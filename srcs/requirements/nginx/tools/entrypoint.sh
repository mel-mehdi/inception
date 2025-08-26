#!/bin/bash

# Update the domain name in nginx config if provided
if [ ! -z "$DOMAIN_NAME" ]; then
    sed -i "s/server_name.*;/server_name $DOMAIN_NAME;/" /etc/nginx/nginx.conf
fi

# Start nginx in foreground
nginx -g "daemon off;"
