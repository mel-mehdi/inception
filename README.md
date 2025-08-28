# Inception - Docker Infrastructure Project

A complete web infrastructure using Docker containers with NGINX, WordPress, MariaDB, and bonus services.

## 📋 Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Services](#services)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## 🏗️ Overview

This project implements a complete web infrastructure using Docker containers. It includes:
- **Core Services**: NGINX (reverse proxy), WordPress (CMS), MariaDB (database)
- **Bonus Services**: Redis (cache), FTP server, Adminer (DB admin), Portainer (container management), Static website

All services run in isolated Docker containers and communicate through a custom network.

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Docker Network                           │
│                  (inception_network)                        │
│                                                             │
│  ┌─────────┐    ┌──────────┐    ┌─────────┐                 │
│  │  NGINX  │◄──►│WordPress │◄──►│ MariaDB │                 │
│  │  :443   │    │   :9000  │    │  :3306  │                 │
│  └─────────┘    └──────┬───┘    └─────────┘                 │
│                        │                                    │
│                        ▼                                    │
│                    ┌─────────┐                              │
│                    │  Redis  │                              │
│                    │  :6379  │                              │
│                    └─────────┘                              │
│                                                             │
│  ┌─────────┐    ┌─────────┐    ┌──────────┐                 │
│  │   FTP   │    │Adminer  │    │Portainer │                 │
│  │ :21,... │    │  :8080  │    │  :9443   │                 │
│  └─────────┘    └─────────┘    └──────────┘                 │
│                                                             │
│                    ┌────────────┐                           │
│                    │Static Site │                           │
│                    │   :8081    │                           │
│                    └────────────┘                           │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Services

### Core Services

#### 1. NGINX (Reverse Proxy)
- **Port**: 443 (HTTPS only)
- **Purpose**: SSL termination and reverse proxy to WordPress
- **Features**: 
  - Self-signed SSL certificate
  - Security headers
  - Gzip compression

#### 2. WordPress
- **Port**: 9000 (internal PHP-FPM)
- **Purpose**: Content Management System
- **Features**:
  - PHP 7.4 with FPM
  - WP-CLI for management
  - Redis integration for caching
  - Pre-configured admin and user accounts

#### 3. MariaDB
- **Port**: 3306 (internal)
- **Purpose**: Database server
- **Features**:
  - Persistent data storage
  - Secure configuration
  - Database initialization scripts

### Bonus Services

#### 4. Redis
- **Port**: 6379 (internal)
- **Purpose**: Caching layer for WordPress
- **Features**:
  - Password authentication
  - Persistent data storage
  - AOF and RDB persistence

#### 5. FTP Server
- **Ports**: 21, 21000-21010
- **Purpose**: File transfer access to WordPress files
- **Features**:
  - VSFTPD server
  - Passive mode support
  - User authentication

#### 6. Adminer
- **Port**: 8080
- **Purpose**: Database administration web interface
- **Features**:
  - Web-based MySQL/MariaDB management
  - Direct connection to MariaDB container

#### 7. Portainer
- **Port**: 9443 (HTTPS)
- **Purpose**: Docker container management
- **Features**:
  - Web-based Docker management
  - Container monitoring
  - SSL enabled

#### 8. Static Website
- **Port**: 8081
- **Purpose**: Simple static website showcase
- **Features**:
  - NGINX server
  - Custom HTML/CSS content

## 🔧 Prerequisites

- Docker Engine (v20.10+)
- Docker Compose (v2.0+)
- Make utility
- Minimum 4GB RAM
- 10GB free disk space

## 📥 Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd inc
   ```

2. **Set up environment variables**:
   ```bash
   # The .env file is already configured in srcs/.env
   # Modify passwords and settings as needed
   ```

3. **Create data directories**:
   ```bash
   # This is done automatically by the Makefile
   make
   ```

4. **Build and start services**:
   ```bash
   make
   ```

## 🚀 Usage

### Starting Services
```bash
# Build and start all containers
make

# Or use individual commands
make build    # Build images only
make up       # Start containers only
```

### Stopping Services
```bash
make down     # Stop containers
make clean    # Remove containers, images, and volumes
make fclean   # Complete cleanup including data
```

### Accessing Services

- **Main Website**: https://melmehdi.42.fr (requires hosts file entry)
- **Adminer**: http://localhost:8080
- **Portainer**: https://localhost:9443
- **Static Site**: http://localhost:8081
- **FTP**: ftp://localhost:21

### Adding Domain to Hosts File
```bash
# Add this line to /etc/hosts (Linux/Mac) or C:\Windows\System32\drivers\etc\hosts (Windows)
127.0.0.1 melmehdi.42.fr
```

### Default Credentials

**WordPress Admin**:
- Username: `melmehdi`
- Password: `admin_password123`
- Email: `melmehdi@student.42.fr`

**WordPress User**:
- Username: `wp_user`
- Password: `wp_user`
- Email: `user@student.42.fr`

**Database (via Adminer)**:
- Server: `mariadb`
- Username: `wp_user`
- Password: `wordpress_user_password123`
- Database: `wordpress`

**FTP**:
- Username: `ftp_user`
- Password: `ftppassword123`

## ⚙️ Configuration

### Environment Variables
Edit `srcs/.env` to customize:
```bash
DOMAIN_NAME=your-domain.com
MYSQL_DATABASE=your_db_name
WP_ADMIN_USER=your_admin
# ... other variables
```

### Secrets Management
Passwords are stored in `secrets/` directory:
- `db_root_password.txt` - MariaDB root password
- `db_password.txt` - WordPress database password
- `credentials.txt` - Additional credentials

### Volume Persistence
Data is persisted in `/home/melmehdi/data/`:
- `mariadb/` - Database files
- `wordpress/` - WordPress files
- `redis/` - Redis data

## 🐛 Troubleshooting

### Common Issues

1. **Permission Denied**:
   ```bash
   sudo chown -R $USER:$USER /home/melmehdi/data/
   ```

2. **Domain Not Resolving**:
   - Add `127.0.0.1 melmehdi.42.fr` to `/etc/hosts`

3. **Containers Not Starting**:
   ```bash
   docker logs <container-name>
   make down && make
   ```

4. **Database Connection Issues**:
   - Ensure MariaDB container is running
   - Check database credentials in secrets files

5. **Redis Connection Issues**:
   - Verify Redis container is running
   - Check Redis password configuration

### Useful Commands

```bash
# View running containers
docker ps

# Check container logs
docker logs <container-name>

# Access container shell
docker exec -it <container-name> bash

# Monitor resources
docker stats

# View networks
docker network ls

# Inspect volumes
docker volume ls
```

### Health Checks

```bash
# Test NGINX
curl -k https://melmehdi.42.fr

# Test WordPress (should redirect to setup)
curl -k https://melmehdi.42.fr/wp-admin

# Test database connection
docker exec -it mariadb mysql -u wp_user -p wordpress

# Test Redis
docker exec -it redis redis-cli ping
```

## 📁 Project Structure

```
inc/
├── Makefile                 # Build automation
├── secrets/                 # Sensitive data
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── .env                 # Environment variables
    ├── docker-compose.yml   # Container orchestration
    └── requirements/
        ├── mariadb/         # Database service
        ├── nginx/           # Web server
        ├── wordpress/       # CMS service
        └── bonus/
            ├── adminer/     # DB admin tool
            ├── ftp/         # File transfer
            ├── portainer/   # Container management
            ├── redis/       # Caching service
            └── static-site/ # Static website
```

## 🔒 Security Features

- HTTPS-only access with SSL certificates
- Database password protection via Docker secrets
- Isolated container network
- Non-root user execution where possible
- Security headers in NGINX configuration
- Redis password authentication

## 🎯 Learning Objectives

This project demonstrates:
- Docker containerization
- Multi-service architecture
- Network isolation and communication
- Volume management and data persistence
- Service orchestration with Docker Compose
- SSL/TLS configuration
- Database management
- Caching strategies
- Web server configuration

---

**Note**: This is an educational project for learning Docker and infrastructure management. For production use, additional security measures and monitoring should be implemented.
