*This project has been created as part of the 42 curriculum by kbrauer.*

# Inception

## Description

This project sets up a small infrastructure composed of different services using Docker Compose. The infrastructure includes:

- **NGINX**: Web server with TLSv1.2/TLSv1.3, serving as the only entry point on port 443
- **WordPress**: PHP-FPM application server for the WordPress CMS
- **MariaDB**: Database server storing WordPress data

All services run in separate containers connected via a Docker bridge network, with persistent data stored in volumes.

### Architecture

```
                        ┌─────────────────────────────────────────┐
                        │          Docker Network: inception      │
    :443 (HTTPS)        │                                         │
   ──────────────►┌───────────┐    :9000     ┌───────────┐        │
                  │   NGINX   │─────────────►│ WordPress │        │
                  │  (TLS 1.2/│  (FastCGI)   │ (PHP-FPM) │        │
                  │   1.3)    │              └─────┬─────┘        │
                  └───────────┘                    │              │
                        │                     :3306│              │
                        │                  ┌───────▼─────┐        │
                        │                  │   MariaDB   │        │
                        │                  └─────────────┘        │
                        └─────────────────────────────────────────┘
                              │                    │
                     ┌────────▼────────┐  ┌────────▼────────┐
                     │   Volume:       │  │   Volume:       │
                     │   wordpress     │  │   mariadb       │
                     │ ~/data/wordpress│  │ ~/data/mariadb  │
                     └─────────────────┘  └─────────────────┘
```

### Virtual Machines vs Docker

| Virtual Machines          | Docker                  |
|---------------------------|-------------------------|
| Full OS with own kernel   | Shares host kernel      |
| Heavy resource usage (GB) | Lightweight (MB)        |
| Slow startup (minutes)    | Fast startup (seconds)  |
| Complete isolation        | Process-level isolation |
| Hardware virtualization   | OS-level virtualization |

Docker is more efficient for running applications because containers share the host's kernel instead of running a complete operating system.

### Secrets vs Environment Variables

| Secrets                                 | Environment Variables   |
|-----------------------------------------|-------------------------|
| Encrypted at rest                       | Stored as plain text    |
| Mounted as files in container           | Available as variables  |
| More secure for sensitive data          | Easier to use           |
| Requires Docker Swarm or external tools | Works with basic Docker |

Environment variables are simpler but less secure. Secrets should be used for sensitive data like passwords in production.

### Docker Network vs Host Network

| Docker Network (Bridge)        | Host Network                     |
|--------------------------------|----------------------------------|
| Isolated network namespace     | Uses host's network directly     |
| Containers communicate by name | No DNS resolution for containers |
| Port mapping required          | No port mapping needed           |
| Better security                | Less secure                      |
| Default and recommended        | Used for specific cases          |

This project uses a bridge network for container isolation and DNS-based service discovery.

### Docker Volumes vs Bind Mounts

| Docker Volumes                     | Bind Mounts          |
|------------------------------------|----------------------|
| Managed by Docker                  | Direct path on host  |
| Stored in /var/lib/docker/volumes  | Any location on host |
| Better portability                 | Host-dependent       |
| Easier backup with Docker commands | Manual backup        |

This project uses bind mounts with `driver_opts` to store data in `/home/kbrauer/data/` as required by the subject.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- Make installed
- Port 443 available

### Installation and Usage
```bash
# Build and start all services
make

# Stop services (removes containers)
make down

# Stop services (keeps containers)
make stop

# Start stopped services
make start

# Restart services
make restart

# View logs
make logs

# Stop + prune Docker system
make clean

# Full cleanup (removes all data and volumes)
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
- Creating project documentation

All AI-generated suggestions were reviewed, understood, and adapted to fit the project requirements.
