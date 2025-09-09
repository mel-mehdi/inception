# Inception - Docker Infrastructure Project

<div align="center">
  <img src="https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/docker-logo-compressed.gif" alt="Docker Logo" width="200"/>
  
  <h3>🚀 Building the Future of Containerized Applications</h3>
  
  <p>
    <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
    <img src="https://img.shields.io/badge/NGINX-009639?style=for-the-badge&logo=nginx&logoColor=white" alt="NGINX"/>
    <img src="https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white" alt="WordPress"/>
    <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white" alt="MariaDB"/>
  </p>
</div>

---

<div align="center">
  <h2>⚡ Quick Start Animation</h2>
  
  <details>
    <summary>🎬 Click to see the magic happen!</summary>
    
<div align="center">
  <div style="font-family: 'Courier New', monospace; background: #1e1e1e; color: #00ff00; padding: 20px; border-radius: 10px; margin: 10px 0;">
    <div style="animation: typing 3s steps(30, end), blink-caret 0.75s step-end infinite;"># Building your infrastructure...</div>
  </div>
  <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Building Animation" width="300"/>
</div>

<div align="center">
  <div style="font-family: 'Courier New', monospace; background: #1e1e1e; color: #00ff00; padding: 20px; border-radius: 10px; margin: 10px 0;">
    <div style="animation: typing 3s steps(25, end) 3s, blink-caret 0.75s step-end infinite 3s;"># Starting services...</div>
  </div>
  <img src="https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" alt="Starting Services" width="300"/>
</div>

<div align="center">
  <div style="font-family: 'Courier New', monospace; background: #1e1e1e; color: #00ff00; padding: 20px; border-radius: 10px; margin: 10px 0;">
    <div style="animation: typing 4s steps(35, end) 6s, blink-caret 0.75s step-end infinite 6s;"># Your site is live! Visit: https://melmehdi.42.fr</div>
  </div>
</div>

<style>
@keyframes typing {
  from { width: 0; }
  to { width: 100%; }
}

@keyframes blink-caret {
  from, to { border-color: transparent; }
  50% { border-color: #00ff00; }
}

div[style*="typing"] {
  overflow: hidden;
  border-right: 3px solid #00ff00;
  white-space: nowrap;
  margin: 0 auto;
  letter-spacing: 0.15em;
}
</style>

  </details>
</div>

---

## 📋 Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Services](#services)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Docker Concepts](#docker-concepts)
- [Project Guide](#project-guide)

## 🏗️ Overview

This project implements a complete web infrastructure using Docker containers. It includes:
- **Core Services**: NGINX (reverse proxy), WordPress (CMS), MariaDB (database)
- **Bonus Services**: Redis (cache), FTP server, Adminer (DB admin), Portainer (container management), Static website

All services run in isolated Docker containers and communicate through a custom network.

## 🏛️ Architecture

<div align="center">
  <h3>🌐 Live Network Flow Animation</h3>
  
  <details>
    <summary>🎭 Click to see the network in action!</summary>
    
<div align="center">
  <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Network Flow" width="400"/>
</div>

```mermaid
graph TD
    A[👤 User] --> B[🌐 NGINX :443]
    B --> C[📝 WordPress :9000]
    C --> D[🗄️ MariaDB :3306]
    C --> E[⚡ Redis :6379]
    
    F[🔧 Adminer :8080] --> D
    G[📁 FTP :21] --> C
    H[🎛️ Portainer :9443] --> I[Docker Engine]
    J[📄 Static Site :8081] --> B
    
    style A fill:#e1f5fe
    style B fill:#4caf50,color:#fff
    style C fill:#2196f3,color:#fff
    style D fill:#ff9800,color:#fff
    style E fill:#9c27b0,color:#fff
```

<div align="center" style="margin-top: 20px;">
  <div style="display: inline-block; background: linear-gradient(45deg, #667eea, #764ba2); color: white; padding: 15px 25px; border-radius: 25px; animation: pulse 2s infinite;">
    <span style="font-size: 1.2em; font-weight: bold;">🔄 Network Active</span>
  </div>
</div>

<style>
@keyframes pulse {
  0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7); }
  50% { transform: scale(1.05); box-shadow: 0 0 0 10px rgba(102, 126, 234, 0); }
}
</style>

  </details>
</div>

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

<div align="center">
  <h3 style="animation: fadeInUp 1s ease-out;">🎯 Service Status Dashboard</h3>
  
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin: 30px 0;">
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 15px; text-align: center; animation: slideInLeft 1s ease-out;">
      <div style="font-size: 3em; margin-bottom: 10px;">🌐</div>
      <h4>NGINX</h4>
      <div style="background: rgba(255,255,255,0.2); padding: 10px; border-radius: 10px; margin: 10px 0;">
        <div style="animation: countUp 2s ease-out forwards;">0</div>
        <small>Port 443 Active</small>
      </div>
      <div style="animation: bounceIn 1s ease-out 0.5s both;">🟢 Online</div>
    </div>
    
    <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; padding: 20px; border-radius: 15px; text-align: center; animation: slideInRight 1s ease-out;">
      <div style="font-size: 3em; margin-bottom: 10px;">📝</div>
      <h4>WordPress</h4>
      <div style="background: rgba(255,255,255,0.2); padding: 10px; border-radius: 10px; margin: 10px 0;">
        <div style="animation: countUp 2s ease-out forwards;">0</div>
        <small>Port 9000 Active</small>
      </div>
      <div style="animation: bounceIn 1s ease-out 0.5s both;">🟢 Online</div>
    </div>
    
    <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; padding: 20px; border-radius: 15px; text-align: center; animation: slideInLeft 1s ease-out 0.3s both;">
      <div style="font-size: 3em; margin-bottom: 10px;">🗄️</div>
      <h4>MariaDB</h4>
      <div style="background: rgba(255,255,255,0.2); padding: 10px; border-radius: 10px; margin: 10px 0;">
        <div style="animation: countUp 2s ease-out forwards;">0</div>
        <small>Port 3306 Active</small>
      </div>
      <div style="animation: bounceIn 1s ease-out 0.5s both;">🟢 Online</div>
    </div>
    
  </div>
  
  <style>
  @keyframes fadeInUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }
  
  @keyframes slideInLeft {
    from { opacity: 0; transform: translateX(-50px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  @keyframes slideInRight {
    from { opacity: 0; transform: translateX(50px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  @keyframes bounceIn {
    0% { opacity: 0; transform: scale(0.3); }
    50% { opacity: 1; transform: scale(1.05); }
    70% { transform: scale(0.9); }
    100% { opacity: 1; transform: scale(1); }
  }
  
  @keyframes countUp {
    from { opacity: 0; }
    to { opacity: 1; }
  }
  </style>
</div>

### Bonus Services

#### 4. Redis
- **Port**: 6379 (internal)
- **Purpose**: Caching layer for WordPress
- **Features**:
  - Password authentication
  - Persistent data storage
  - AOF and RDB persistence

#### 5. FTP Server
- **Ports**: 21, 21000-21010make
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

<div align="center">
  <h3>🚀 Installation Progress</h3>
  
  <details>
    <summary>📋 Click to see installation steps with animations!</summary>
    
<div align="center">
  <div style="width: 100%; max-width: 600px; margin: 20px 0;">
    <div style="background: #f0f0f0; border-radius: 20px; padding: 3px;">
      <div style="height: 20px; background: linear-gradient(90deg, #4CAF50, #45b7d1); border-radius: 17px; width: 0%; animation: progressBar 3s ease-out forwards;"></div>
    </div>
    <div style="margin-top: 10px; font-weight: bold; animation: fadeIn 1s ease-out;">Step 1: Clone Repository</div>
  </div>
  
  <div style="font-family: 'Courier New', monospace; background: #2d3748; color: #68d391; padding: 15px; border-radius: 10px; margin: 10px 0; animation: slideInUp 1s ease-out;">
    <div style="animation: typing 2s steps(40, end), blink-caret 0.75s step-end infinite;">git clone &lt;repository-url&gt; &amp;&amp; cd inception</div>
  </div>
  
  <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Installation" width="300"/>
</div>

<div align="center">
  <div style="width: 100%; max-width: 600px; margin: 20px 0;">
    <div style="background: #f0f0f0; border-radius: 20px; padding: 3px;">
      <div style="height: 20px; background: linear-gradient(90deg, #2196F3, #21CBF3); border-radius: 17px; width: 0%; animation: progressBar 3s ease-out 3s forwards;"></div>
    </div>
    <div style="margin-top: 10px; font-weight: bold; animation: fadeIn 1s ease-out 3s both;">Step 2: Setup Environment</div>
  </div>
  
  <div style="font-family: 'Courier New', monospace; background: #2d3748; color: #68d391; padding: 15px; border-radius: 10px; margin: 10px 0; animation: slideInUp 1s ease-out 3s both;">
    <div style="animation: typing 2s steps(35, end) 3s, blink-caret 0.75s step-end infinite 3s;"># Environment configured successfully</div>
  </div>
</div>

<div align="center">
  <div style="width: 100%; max-width: 600px; margin: 20px 0;">
    <div style="background: #f0f0f0; border-radius: 20px; padding: 3px;">
      <div style="height: 20px; background: linear-gradient(90deg, #FF9800, #FFC107); border-radius: 17px; width: 0%; animation: progressBar 3s ease-out 6s forwards;"></div>
    </div>
    <div style="margin-top: 10px; font-weight: bold; animation: fadeIn 1s ease-out 6s both;">Step 3: Create Directories</div>
  </div>
  
  <div style="font-family: 'Courier New', monospace; background: #2d3748; color: #68d391; padding: 15px; border-radius: 10px; margin: 10px 0; animation: slideInUp 1s ease-out 6s both;">
    <div style="animation: typing 2s steps(25, end) 6s, blink-caret 0.75s step-end infinite 6s;">make</div>
  </div>
</div>

<div align="center">
  <div style="width: 100%; max-width: 600px; margin: 20px 0;">
    <div style="background: #f0f0f0; border-radius: 20px; padding: 3px;">
      <div style="height: 20px; background: linear-gradient(90deg, #4CAF50, #66BB6A); border-radius: 17px; width: 0%; animation: progressBar 3s ease-out 9s forwards;"></div>
    </div>
    <div style="margin-top: 10px; font-weight: bold; animation: fadeIn 1s ease-out 9s both;">Step 4: Build & Start</div>
  </div>
  
  <div style="font-family: 'Courier New', monospace; background: #2d3748; color: #68d391; padding: 15px; border-radius: 10px; margin: 10px 0; animation: slideInUp 1s ease-out 9s both;">
    <div style="animation: typing 2s steps(20, end) 9s, blink-caret 0.75s step-end infinite 9s;">make</div>
  </div>
  
  <div style="animation: zoomIn 1s ease-out 12s both;">
    <img src="https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" alt="Success!" width="200"/>
    <h3>🎉 Your infrastructure is ready!</h3>
  </div>
</div>

<style>
@keyframes progressBar {
  from { width: 0%; }
  to { width: 100%; }
}

@keyframes slideInUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes zoomIn {
  from { opacity: 0; transform: scale(0.5); }
  to { opacity: 1; transform: scale(1); }
}
</style>

  </details>
</div>

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
- Server: `localhost:21`
- Access: `ftp://localhost:21`

## ⚙️ Configuration

### Environment Variables
Edit `srcs/.env` to customize:
```bash
DOMAIN_NAME=your-domain.com
MYSQL_DATABASE=your_db_name
WP_ADMIN_USER=your_admin
# ... other variables
```
ftp localhost 21
# Then enter: ftp_user / ftppassword123

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

6. **FTP/WordPress File Upload Issues**:
   ```bash
   # If you get "Unable to locate WordPress content directory" error
   docker exec wordpress bash -c "cd /var/www/html && wp config set FS_METHOD direct --allow-root"
   docker exec wordpress chown -R www-data:www-data /var/www/html
   docker restart wordpress
   ```

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

# 🐳 الفرق بين Container و Image

<div align="center">
  <h2>🎭 Animated Docker Concepts</h2>
  
  <details>
    <summary>🎬 Click to see Docker magic in action!</summary>
    
<div align="center">
  <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Docker Animation" width="400"/>
</div>

<div align="center" style="margin: 30px 0;">
  <div style="display: inline-block; animation: float 3s ease-in-out infinite;">
    <div style="background: linear-gradient(45deg, #FF6B6B, #4ECDC4); color: white; padding: 20px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
      <h3 style="margin: 0; animation: textGlow 2s ease-in-out infinite alternate;">🐳 Docker World</h3>
    </div>
  </div>
</div>

  </details>
</div>

## المقارنة الأساسية

<div align="center">
  <table style="border-collapse: collapse; animation: tableFadeIn 2s ease-out;">
    <tr>
      <td align="center" style="padding: 20px; animation: slideInFromLeft 1s ease-out;">
        <div style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 30px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); animation: cardHover 3s ease-in-out infinite;">
          <h3>📦 Docker Image</h3>
          <img src="https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" alt="Image Animation" width="150"/>
          <p><strong>الصورة = القالب الثابت</strong></p>
          <ul align="right" style="list-style: none; padding: 0;">
            <li style="animation: listItemFade 1s ease-out 0.5s both;">🔒 للقراءة فقط</li>
            <li style="animation: listItemFade 1s ease-out 0.7s both;">💾 مخزنة على القرص</li>
            <li style="animation: listItemFade 1s ease-out 0.9s both;">🏗️ أساس بناء الحاويات</li>
            <li style="animation: listItemFade 1s ease-out 1.1s both;">🌐 قابلة للمشاركة</li>
          </ul>
        </div>
      </td>
      <td align="center" style="padding: 20px; animation: slideInFromRight 1s ease-out;">
        <div style="background: linear-gradient(135deg, #f093fb, #f5576c); color: white; padding: 30px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); animation: cardHover 3s ease-in-out infinite 1s;">
          <h3>🏃 Docker Container</h3>
          <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Container Animation" width="150"/>
          <p><strong>الحاوية = التطبيق يعمل فعلياً</strong></p>
          <ul align="right" style="list-style: none; padding: 0;">
            <li style="animation: listItemFade 1s ease-out 0.5s both;">🔄 قيد التشغيل</li>
            <li style="animation: listItemFade 1s ease-out 0.7s both;">💭 تستهلك ذاكرة</li>
            <li style="animation: listItemFade 1s ease-out 0.9s both;">✏️ قابلة للتعديل</li>
            <li style="animation: listItemFade 1s ease-out 1.1s both;">⏰ لها دورة حياة</li>
          </ul>
        </div>
      </td>
    </tr>
  </table>
  
  <style>
  @keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
  }
  
  @keyframes textGlow {
    from { text-shadow: 0 0 10px #fff; }
    to { text-shadow: 0 0 20px #fff, 0 0 30px #fff; }
  }
  
  @keyframes tableFadeIn {
    from { opacity: 0; transform: scale(0.9); }
    to { opacity: 1; transform: scale(1); }
  }
  
  @keyframes slideInFromLeft {
    from { opacity: 0; transform: translateX(-100px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  @keyframes slideInFromRight {
    from { opacity: 0; transform: translateX(100px); }
    to { opacity: 1; transform: translateX(0); }
  }
  
  @keyframes cardHover {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-5px); }
  }
  
  @keyframes listItemFade {
    from { opacity: 0; transform: translateX(20px); }
    to { opacity: 1; transform: translateX(0); }
  }
  </style>
</div>

## 🍳 تشبيه كتاب الطبخ

| كتاب الطبخ (Docker Image) | ➡️ | الطبق المطبوخ (Docker Container) |
|---------------------------|-----|----------------------------------|
| 📖 وصفات مكتوبة          |     | 🔥 نتيجة تطبيق الوصفة          |
| 🔒 لا تتغير              |     | 🍴 قابل للاستهلاك              |
| 📤 يمكن مشاركتها         |     | 🔄 يمكن تكراره                 |

## ⚙️ من الصورة إلى الحاوية

1. 📦 **لديك صورة** - قالب ثابت جاهز للاستخدام
   ```
   nginx:latest
   ```

2. 🔨 **تشغل أمر** - تحول الصورة إلى حاوية
   ```bash
   docker run nginx
   ```

3. ✨ **حاوية تعمل** - التطبيق أصبح نشطاً
   - 🌐 موقع ويب يعمل

## 🔢 صورة واحدة ← عدة حاويات

**صورة واحدة:** nginx:latest

**تتحول إلى عدة حاويات:**
- 🌐 حاوية 1: موقع شركة
- 🛒 حاوية 2: متجر إلكتروني
- 📱 حاوية 3: تطبيق API

**✨ المعنى:** من صورة واحدة يمكن إنشاء حاويات متعددة تعمل بشكل منفصل!

## 🔍 الفروق الرئيسية

### Docker Image
- 🔒 ثابتة وغير قابلة للتغيير
- 💾 مخزنة على القرص الصلب
- 📋 تحتوي على التعليمات فقط
- ⚡ لا تستهلك معالج أو ذاكرة
- 🏗️ أساس لإنشاء الحاويات

### Docker Container
- 🔄 نشطة ومتغيرة
- 💭 تستخدم الذاكرة والمعالج
- 🎯 التطبيق يعمل فعلياً
- ⏰ لها دورة حياة (بداية ونهاية)
- ✏️ يمكن التفاعل معها وتعديلها

## 💡 مثال عملي: تطبيق ويب

**الصورة:**
- 🐧 Ubuntu Linux
- 🔧 Node.js
- 📁 كود التطبيق
- 🔌 المكتبات
- حجم: 200MB على القرص

**الحاوية:**
- 🔄 التطبيق يعمل
- 🌐 Port: 3000
- 💭 يستخدم 50MB ذاكرة
- 🔧 يمكن التحكم به
- الحالة: 🟢 نشط

## 💻 أوامر عملية

### التعامل مع الصور
```bash
# سحب صورة
docker pull nginx

# عرض الصور
docker images

# بناء صورة
docker build -t myapp .
```

### التعامل مع الحاويات
```bash
# تشغيل حاوية
docker run -d nginx

# عرض الحاويات النشطة
docker ps

# إيقاف حاوية
docker stop container_id
```

## 🎉 اتذكر
- 📦 **الصورة** = الخطة أو القالب
- 🏃 **الحاوية** = التطبيق يعمل من الخطة
- 💡 صورة واحدة ← عدة حاويات

# 🐳 شرح Docker بالصور والمخططات

## 🔄 مقارنة الطريقة التقليدية مع Docker

### ❌ الطريقة التقليدية
**المشاكل:**
- استهلاك عالي للذاكرة
- بطء في الإقلاع
- تعقيد في الإدارة

```
Hardware
├── نظام التشغيل المضيف
├── Virtual Machine 1
│   ├── Guest OS 1
│   └── التطبيق 1
```

### ✅ طريقة Docker
**المميزات:**
- استهلاك أقل للموارد
- إقلاع سريع
- إدارة مبسطة

```
Hardware
├── نظام التشغيل المضيف
├── Docker Engine
├── Container 1
│   └── التطبيق 1
```

## 🏗️ معمارية Docker

### Virtual Machines
```
Hypervisor
├── Guest OS ── App A
└── Guest OS ── App B
Host Operating System
Infrastructure
```

### Docker Containers
```
Container A
Container B
Docker Engine
Host Operating System
Infrastructure
```

## ⚙️ سير عمل Docker

<div align="center">
  <h3>🔄 Docker Workflow Animation</h3>
  
  <details>
    <summary>🎬 Click to see the workflow in motion!</summary>
    
<div align="center">
  <div style="position: relative; width: 100%; max-width: 800px; margin: 30px 0;">
    <!-- Workflow Steps -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
      
      <div style="text-align: center; animation: stepBounce 2s ease-out;">
        <div style="width: 80px; height: 80px; background: linear-gradient(45deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
          <span style="font-size: 2em;">📝</span>
        </div>
        <div style="background: #667eea; color: white; padding: 10px 20px; border-radius: 20px; animation: stepText 1s ease-out;">
          Dockerfile
        </div>
      </div>
      
      <div style="width: 100px; height: 4px; background: linear-gradient(90deg, #667eea, #764ba2); animation: lineGrow 2s ease-out 1s both;"></div>
      
      <div style="text-align: center; animation: stepBounce 2s ease-out 1s;">
        <div style="width: 80px; height: 80px; background: linear-gradient(45deg, #f093fb, #f5576c); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
          <span style="font-size: 2em;">🏗️</span>
        </div>
        <div style="background: #f093fb; color: white; padding: 10px 20px; border-radius: 20px; animation: stepText 1s ease-out 1s both;">
          Build Image
        </div>
      </div>
      
      <div style="width: 100px; height: 4px; background: linear-gradient(90deg, #f093fb, #f5576c); animation: lineGrow 2s ease-out 2s both;"></div>
      
      <div style="text-align: center; animation: stepBounce 2s ease-out 2s;">
        <div style="width: 80px; height: 80px; background: linear-gradient(45deg, #4facfe, #00f2fe); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
          <span style="font-size: 2em;">🚀</span>
        </div>
        <div style="background: #4facfe; color: white; padding: 10px 20px; border-radius: 20px; animation: stepText 1s ease-out 2s both;">
          Run Container
        </div>
      </div>
      
      <div style="width: 100px; height: 4px; background: linear-gradient(90deg, #4facfe, #00f2fe); animation: lineGrow 2s ease-out 3s both;"></div>
      
      <div style="text-align: center; animation: stepBounce 2s ease-out 3s;">
        <div style="width: 80px; height: 80px; background: linear-gradient(45deg, #43e97b, #38f9d7); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
          <span style="font-size: 2em;">☁️</span>
        </div>
        <div style="background: #43e97b; color: white; padding: 10px 20px; border-radius: 20px; animation: stepText 1s ease-out 3s both;">
          Deploy
        </div>
      </div>
      
    </div>
    
    <!-- Progress Counter -->
    <div style="text-align: center; margin-top: 30px;">
      <div style="font-size: 2em; font-weight: bold; color: #667eea; animation: counter 4s ease-out;">
        <span style="animation: numberCount 4s ease-out;">0</span>%
      </div>
      <div style="width: 100%; height: 10px; background: #f0f0f0; border-radius: 5px; overflow: hidden;">
        <div style="height: 100%; background: linear-gradient(90deg, #667eea, #764ba2, #f093fb, #f5576c, #4facfe, #00f2fe, #43e97b, #38f9d7); animation: progressFill 4s ease-out;"></div>
      </div>
    </div>
  </div>
  
  <img src="https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" alt="Workflow Animation" width="300"/>
</div>

```mermaid
flowchart TD
    A[📝 كتابة Dockerfile] --> B[🏗️ بناء الصورة]
    B --> C[🚀 تشغيل الحاوية]
    C --> D[☁️ النشر]
    
    style A fill:#e3f2fd
    style B fill:#fff3e0
    style C fill:#e8f5e8
    style D fill:#fce4ec
```

### Progress Through Workflow:
<div align="center">
  <img src="https://progress-bar.dev/25/?title=Dockerfile" alt="Dockerfile: 25%"/>
  <img src="https://progress-bar.dev/50/?title=Build%20Image" alt="Build: 50%"/>
  <img src="https://progress-bar.dev/75/?title=Run%20Container" alt="Run: 75%"/>
  <img src="https://progress-bar.dev/100/?title=Deploy&color=brightgreen" alt="Deploy: 100%"/>
</div>

<style>
@keyframes stepBounce {
  0% { transform: scale(0); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

@keyframes stepText {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes lineGrow {
  from { width: 0; }
  to { width: 100px; }
}

@keyframes counter {
  from { opacity: 0; }
  to { opacity: 1; }
}

  @keyframes numberCount {
    0% { opacity: 0.3; }
    25% { opacity: 0.5; }
    50% { opacity: 0.7; }
    75% { opacity: 0.9; }
    100% { opacity: 1; }
  }@keyframes progressFill {
  0% { width: 0%; }
  25% { width: 25%; }
  50% { width: 50%; }
  75% { width: 75%; }
  100% { width: 100%; }
}
</style>

  </details>
</div>

1. 📝 **كتابة Dockerfile** - تعريف بيئة التطبيق والاعتمادات
2. 🏗️ **بناء الصورة** - `docker build -t myapp .`
3. 🚀 **تشغيل الحاوية** - `docker run myapp`
4. ☁️ **النشر** - رفع للسحابة أو خوادم أخرى

## 🎯 المفاهيم الأساسية المصورة

<div align="center">
  <h3>🌟 Interactive Docker Concepts</h3>
  
  <details>
    <summary>🎭 Click to explore Docker concepts!</summary>
    
<div align="center">
  <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Concepts Animation" width="350"/>
</div>

### 📦 Docker Image (الصورة)
<div align="center">
  <img src="https://img.shields.io/badge/Image-Static%20Template-blue?style=for-the-badge&logo=docker" alt="Image Badge"/>
</div>
قالب للقراءة فقط يحتوي على كل ما يحتاجه التطبيق:
- 🐧 نظام التشغيل الأساسي
- 📚 المكتبات والتبعيات
- 💻 كود التطبيق
- ⚙️ إعدادات البيئة

### 🏃 Docker Container (الحاوية)
<div align="center">
  <img src="https://img.shields.io/badge/Container-Running%20Instance-green?style=for-the-badge&logo=docker" alt="Container Badge"/>
</div>
نسخة تشغيل حية من الصورة:
- 🔄 التطبيق يعمل هنا
- 📁 نظام ملفات معزول
- 🌐 شبكة معزولة

  </details>
</div>

## 🚀 الفوائد الرئيسية

- 🎯 **قابلية النقل** - يعمل في أي مكان بنفس الطريقة
- ⚡ **السرعة** - إقلاع سريع وأداء عالي
- 🛡️ **العزل** - كل تطبيق في بيئة منفصلة
- 💰 **توفير الموارد** - استهلاك أقل للذاكرة والمعالج

## 📊 مقارنة سريعة: Containers vs Virtual Machines

| المعيار | Docker Containers | Virtual Machines |
|---------|-------------------|------------------|
| وقت الإقلاع | ثوانٍ | دقائق |
| استهلاك الذاكرة | منخفض (MBs) | عالي (GBs) |
| نظام التشغيل | مشارك | منفصل لكل VM |
| الأمان | عزل على مستوى العملية | عزل كامل |

## 💻 الأوامر الأساسية

```bash
# تشغيل حاوية جديدة
docker run -d --name myapp nginx

# عرض الحاويات النشطة
docker ps

# بناء صورة من Dockerfile
docker build -t myimage:latest .

# إيقاف حاوية
docker stop myapp

# حذف حاوية
docker rm myapp

# عرض الصور المحلية
docker images

# سحب صورة من Docker Hub
docker pull ubuntu:20.04
```

## 🔄 دورة حياة Docker

📝 **Dockerfile** → 📦 **Docker Image** → 🏃 **Container**

## 🌟 حالات الاستخدام الشائعة

- 🔧 **تطوير التطبيقات** - بيئة موحدة لجميع المطورين
- ☁️ **النشر السحابي** - نشر سهل وسريع للتطبيقات
- 🧪 **الاختبار** - اختبار في بيئات مختلفة بسهولة
- ⚖️ **التوسع** - زيادة عدد الحاويات حسب الطلب

## 💡 مثال عملي: تشغيل موقع ويب

📁 مجلد المشروع → 🔨 **بناء الصورة** → ▶️ **تشغيل الموقع**

```bash
# إنشاء Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/

# بناء الصورة
docker build -t my-website .

# تشغيل الموقع
docker run -p 8080:80 my-website
```

## 🎉 الخلاصة
Docker يجعل تطوير ونشر التطبيقات أسهل وأسرع وأكثر موثوقية!

# 🏗️ Inception Project Architecture Guide

## 📐 Project Architecture Overview

### Services

#### 🌐 NGINX
- **Port:** 443 (HTTPS only)
- SSL/TLS Certificate
- Reverse Proxy
- Static Files

#### 📝 WordPress + PHP-FPM
- **Port:** 9000 (internal)
- CMS System
- PHP Processing
- User Interface

#### 🗄️ MariaDB
- **Port:** 3306 (internal)
- Database Server
- Data Persistence
- WordPress Backend

## 🔗 Network Flow

👤 **User** → 🌐 **NGINX** (Port 443) → 📝 **WordPress** (PHP Processing) → 🗄️ **MariaDB** (Database Query)

## 📋 Key Requirements

### 🐳 Docker Requirements
- Custom Dockerfiles (no pre-built images)
- Alpine or Debian base images
- No ready-made containers from DockerHub
- Each service in separate container

### 🔐 Security Requirements
- HTTPS only (port 443)
- SSL/TLS certificate
- Environment variables in .env
- No credentials in repository

### 🗂️ Structure Requirements
- srcs/ folder at repository root
- Makefile at repository root
- docker-compose.yml in srcs/
- Dockerfiles in respective directories

### 💾 Persistence Requirements
- Docker volumes for data
- WordPress files volume
- Database data volume
- Data survives container restart

## 📁 Required Directory Structure

```
inception/
├── Makefile
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        └── mariadb/
            ├── Dockerfile
            ├── conf/
            └── tools/
```

## 💾 Volume Configuration

### 📁 WordPress Volume
`/home/[login]/data/wordpress` → `/var/www/html`

### 🗄️ MariaDB Volume
`/home/[login]/data/mariadb` → `/var/lib/mysql`

## ✅ Evaluation Checklist

- 🔍 Custom Dockerfiles for each service (no DockerHub images)
- 🔒 NGINX accessible only via HTTPS (port 443)
- 🌐 Website accessible at https://[login].42.fr
- 📝 WordPress properly configured (no installation page)
- 🗄️ MariaDB database populated and accessible
- 💾 Data persists after system reboot
- 🔗 Docker network configured (no host network or links)
- 🚫 No infinite loops or background processes in Dockerfiles

## 🎯 Learning Objectives

- Understand Docker containerization concepts
- Learn docker-compose for multi-service applications
- Implement secure web server configuration
- Practice infrastructure as code principles

## 💡 Study Resources

- 📚 Docker Documentation: Official Docker docs
- 🔧 Docker Compose Guide: Multi-container applications
- 🌐 NGINX Configuration: SSL/TLS setup
- 📝 WordPress with Docker: PHP-FPM configuration
- 🗄️ MariaDB Setup: Database initialization

---

<div align="center">
  <h2>🎉 Thank You for Exploring!</h2>
  
  <details>
    <summary>🎬 Click for a final celebration!</summary>
    
<div align="center">
  <img src="https://media.giphy.com/media/l0MYt5jPR6QX5pnqM/giphy.gif" alt="Celebration" width="400"/>
  
  <h3>🚀 You've mastered Docker containerization!</h3>
  
  <p>
    <img src="https://img.shields.io/badge/Made%20with-❤️-red?style=for-the-badge" alt="Made with Love"/>
    <img src="https://img.shields.io/badge/Powered%20by-Docker-blue?style=for-the-badge&logo=docker" alt="Powered by Docker"/>
    <img src="https://img.shields.io/badge/Learn-More-green?style=for-the-badge" alt="Learn More"/>
  </p>
  
  <div align="center">
    <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Docker Success" width="200"/>
  </div>
  
  <h4>🌟 Keep building amazing things with Docker! 🌟</h4>
</div>

  </details>
</div>

---

**Note**: This is an educational project for learning Docker and infrastructure management. For production use, additional security measures and monitoring should be implemented.

---

<div align="center">
  <h2>🎉 Thank You for Exploring!</h2>
  
  <details>
    <summary>🎬 Click for a final celebration!</summary>
    
<div align="center">
  <div style="position: relative; overflow: hidden; border-radius: 20px; margin: 20px 0;">
    <div style="background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #f5576c, #4facfe, #00f2fe); background-size: 400% 400%; animation: gradientShift 3s ease infinite; padding: 40px; color: white; text-align: center;">
      <h3 style="animation: textBounce 2s ease-in-out infinite; margin: 0;">🚀 You've mastered Docker containerization!</h3>
    </div>
  </div>
  
  <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 30px 0;">
    <div style="background: linear-gradient(135deg, #ff9a9e, #fecfef); padding: 20px; border-radius: 15px; text-align: center; animation: cardFlip 2s ease-out;">
      <div style="font-size: 3em; animation: emojiBounce 1s ease-in-out infinite;">🎯</div>
      <h4>Learning Complete</h4>
      <p>Docker concepts mastered!</p>
    </div>
    
    <div style="background: linear-gradient(135deg, #a8edea, #fed6e3); padding: 20px; border-radius: 15px; text-align: center; animation: cardFlip 2s ease-out 0.5s both;">
      <div style="font-size: 3em; animation: emojiBounce 1s ease-in-out infinite 0.5s;">🚀</div>
      <h4>Ready to Deploy</h4>
      <p>Infrastructure ready!</p>
    </div>
    
    <div style="background: linear-gradient(135deg, #d299c2, #fef9d7); padding: 20px; border-radius: 15px; text-align: center; animation: cardFlip 2s ease-out 1s both;">
      <div style="font-size: 3em; animation: emojiBounce 1s ease-in-out infinite 1s;">🌟</div>
      <h4>Future Ready</h4>
      <p>Build amazing things!</p>
    </div>
  </div>
  
  <p>
    <img src="https://img.shields.io/badge/Made%20with-❤️-red?style=for-the-badge" alt="Made with Love"/>
    <img src="https://img.shields.io/badge/Powered%20by-Docker-blue?style=for-the-badge&logo=docker" alt="Powered by Docker"/>
    <img src="https://img.shields.io/badge/Learn-More-green?style=for-the-badge" alt="Learn More"/>
  </p>
  
  <div align="center" style="margin-top: 30px;">
    <div style="display: inline-block; animation: rocketLaunch 3s ease-in-out infinite;">
      <img src="https://media.giphy.com/media/3o7TKz9bX9Z8LxOq5i/giphy.gif" alt="Docker Success" width="200"/>
    </div>
  </div>
  
  <h4 style="animation: fadeInOut 2s ease-in-out infinite;">🌟 Keep building amazing things with Docker! 🌟</h4>
</div>

  </details>
</div>

<style>
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

@keyframes textBounce {
  0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-10px); }
  60% { transform: translateY(-5px); }
}

@keyframes cardFlip {
  from { opacity: 0; transform: rotateY(180deg); }
  to { opacity: 1; transform: rotateY(0deg); }
}

@keyframes emojiBounce {
  0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
  40% { transform: translateY(-10px); }
  60% { transform: translateY(-5px); }
}

@keyframes rocketLaunch {
  0%, 100% { transform: translateY(0px) rotate(0deg); }
  25% { transform: translateY(-5px) rotate(1deg); }
  50% { transform: translateY(-10px) rotate(-1deg); }
  75% { transform: translateY(-5px) rotate(0.5deg); }
}

@keyframes fadeInOut {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}
</style>

---

**Note**: This is an educational project for learning Docker and infrastructure management. For production use, additional security measures and monitoring should be implemented.
