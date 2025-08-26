FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration
COPY tools/vsftpd.conf /etc/vsftpd.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Create FTP directory
RUN mkdir -p /var/ftp

EXPOSE 21 21000-21010

ENTRYPOINT ["/entrypoint.sh"]
