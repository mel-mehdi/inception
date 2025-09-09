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

## المقارنة الأساسية

### Docker Image (الصورة)
📦 **الصورة = القالب الثابت**

**خصائص الصورة:**
- 🔒 للقراءة فقط
- 💾 مخزنة على القرص
- 🏗️ أساس بناء الحاويات
- 🌐 قابلة للمشاركة

### Docker Container (الحاوية)
🏃 **الحاوية = التطبيق يعمل فعلياً**

**خصائص الحاوية:**
- 🔄 قيد التشغيل
- 💭 تستهلك ذاكرة
- ✏️ قابلة للتعديل
- ⏰ لها دورة حياة

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

1. 📝 **كتابة Dockerfile** - تعريف بيئة التطبيق والاعتمادات
2. 🏗️ **بناء الصورة** - `docker build -t myapp .`
3. 🚀 **تشغيل الحاوية** - `docker run myapp`
4. ☁️ **النشر** - رفع للسحابة أو خوادم أخرى

## 🎯 المفاهيم الأساسية المصورة

### 📦 Docker Image (الصورة)
قالب للقراءة فقط يحتوي على كل ما يحتاجه التطبيق:
- نظام التشغيل الأساسي
- المكتبات والتبعيات
- كود التطبيق
- إعدادات البيئة

### 🏃 Docker Container (الحاوية)
نسخة تشغيل حية من الصورة:
- 🔄 التطبيق يعمل هنا
- 📁 نظام ملفات معزول
- 🌐 شبكة معزولة

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
