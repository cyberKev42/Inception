# Developer Documentation - Inception

## Prerequisites

- Docker Engine 20.10+
- Docker Compose v2.0+
- Make
- Git
- Debian/Ubuntu VM (recommended)

## Project Structure
```
inception/
├── Makefile                 # Build automation
├── README.md                # Project overview
├── USER_DOC.md              # User documentation
├── DEV_DOC.md               # Developer documentation
└── srcs/
    ├── .env                 # Environment variables
    ├── docker-compose.yml   # Service orchestration
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/
        │   └── tools/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/
        └── wordpress/
            ├── Dockerfile
            └── tools/
```

## Environment Setup

### 1. Clone the Repository
```bash
git clone <repository-url> inception
cd inception
```

### 2. Configure Environment Variables
Edit `srcs/.env` with your settings:
```
DOMAIN_NAME=login.42.fr
MYSQL_ROOT_PASSWORD=your_secure_password
MYSQL_DATABASE=wordpress
MYSQL_USER=your_db_user
MYSQL_PASSWORD=your_db_password
WP_ADMIN_USER=your_admin_name
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=your@email.com
```

### 3. Configure Domain Name
Add to `/etc/hosts`:
```
127.0.0.1    login.42.fr
```

### 4. Create Data Directories
```bash
mkdir -p /home/login/data/wordpress
mkdir -p /home/login/data/mariadb
```

## Building and Running

### Build and Start
```bash
make
```
This runs `docker-compose up -d --build`

### Rebuild Everything
```bash
make re
```
This cleans all data and rebuilds from scratch.

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make` | Create directories and start services |
| `make up` | Start services |
| `make down` | Stop and remove containers |
| `make stop` | Stop containers without removing |
| `make start` | Start stopped containers |
| `make restart` | Restart all services |
| `make logs` | Follow container logs |
| `make clean` | Stop containers and prune Docker |
| `make fclean` | Full cleanup including volumes |
| `make re` | Rebuild from scratch |

## Docker Compose Commands
```bash
# View running containers
docker-compose -f srcs/docker-compose.yml ps

# Execute command in container
docker exec -it wordpress bash
docker exec -it mariadb bash
docker exec -it nginx bash

# View specific logs
docker logs wordpress
docker logs mariadb
docker logs nginx
```

## Data Persistence

### Volume Locations
| Volume | Host Path | Container Path |
|--------|-----------|----------------|
| wordpress | /home/login/data/wordpress | /var/www/html |
| mariadb | /home/login/data/mariadb | /var/lib/mysql |

### Backup Data
```bash
# Backup WordPress files
cp -r /home/login/data/wordpress ./backup/wordpress

# Backup Database
docker exec mariadb mysqldump -u root -p wordpress > backup.sql
```

## Network Architecture

All containers connect via the `inception` bridge network:
- NGINX: Exposed on port 443
- WordPress: Internal port 9000 (FastCGI)
- MariaDB: Internal port 3306

## Troubleshooting

### Container Won't Start
```bash
docker logs <container_name>
```

### Permission Issues
```bash
sudo chown -R $USER:$USER /home/login/data/
```

### Rebuild Single Service
```bash
docker-compose -f srcs/docker-compose.yml up -d --build <service_name>
```
