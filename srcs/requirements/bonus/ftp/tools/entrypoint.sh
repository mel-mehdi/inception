#!/bin/bash

# Create FTP user if it doesn't exist
if ! id "$FTP_USER" &>/dev/null; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m -d /var/ftp -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

# Set permissions
chown -R "$FTP_USER:$FTP_USER" /var/ftp
chmod -R 755 /var/ftp

# Create empty chroot directory
mkdir -p /var/run/vsftpd/empty

# Start vsftpd
exec vsftpd /etc/vsftpd.conf
