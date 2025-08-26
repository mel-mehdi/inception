#!/bin/bash

# Configure Redis password
if [ ! -z "$REDIS_PASSWORD" ]; then
    echo "requirepass $REDIS_PASSWORD" >> /etc/redis/redis.conf
fi

# Start Redis server
exec redis-server /etc/redis/redis.conf
