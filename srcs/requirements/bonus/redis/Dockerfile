FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

# Create data directory and set permissions
RUN mkdir -p /data /var/log/redis \
    && chown -R redis:redis /data /var/log/redis /etc/redis

# Copy configuration and scripts
COPY tools/redis.conf /etc/redis/redis.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh \
    && chown redis:redis /etc/redis/redis.conf

EXPOSE 6379

USER redis
WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
