*This project has been created as part of the 42 curriculum by kbrauer.*

# Inception

## Description

This project sets up a small infrastructure composed of different services using Docker Compose. The infrastructure includes:

- **NGINX**: Web server with TLSv1.2/TLSv1.3, serving as the only entry point on port 443
- **WordPress**: PHP-FPM application server for the WordPress CMS
- **MariaDB**: Database server storing WordPress data

All services run in separate containers connected via a Docker bridge network, with persistent data stored in volumes.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- Make installed
- Port 443 available

### Installation and Usage
```bash
# Build and start all services
make

# Stop services
make down

# View logs
make logs

# Full cleanup (removes all data)
make fclean

# Rebuild from scratch
make re
```

### Access
- Website: https://kbrauer.42.fr
- Admin panel: https://kbrauer.42.fr/wp-admin

## Resources

### Documentation
- [Docker Documentation](https://docs.docker.com/)
- [WordPress Documentation](https://developer.wordpress.org/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

### AI Usage
AI was used during this project for:
- Understanding Docker concepts and best practices
- Debugging configuration issues
- Learning about service communication in containerized environments

All AI-generated suggestions were reviewed, understood, and adapted to fit the project requirements.
