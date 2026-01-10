# User Documentation - Inception

## Overview

This infrastructure provides a WordPress website running on a secure HTTPS connection.

## Services Provided

| Service | Description |
|---------|-------------|
| WordPress | Content management system for creating and managing your website |
| Database | MariaDB storing all website content and user data |
| Web Server | NGINX handling secure HTTPS connections |

## Starting and Stopping

### Start the Project
```bash
make
```

### Stop the Project
```bash
make down
```

### Restart Services
```bash
make restart
```

## Accessing the Website

### Main Website
Open your browser and navigate to:
```
https://kbrauer.42.fr
```
Note: You will see a certificate warning because we use a self-signed certificate. Click "Advanced" and proceed.

### Administration Panel
Access the WordPress admin dashboard at:
```
https://kbrauer.42.fr/wp-admin
```

Login credentials are stored in `srcs/.env` file.

## Managing Credentials

All credentials are stored in `srcs/.env`:
- `WP_ADMIN_USER`: WordPress administrator username
- `WP_ADMIN_PASSWORD`: WordPress administrator password
- `WP_USER`: Regular WordPress user
- `MYSQL_USER`: Database username
- `MYSQL_PASSWORD`: Database password

## Checking Service Status

### Verify All Services Running
```bash
docker ps
```
You should see three containers: nginx, wordpress, mariadb

### View Service Logs
```bash
make logs
```
Or for a specific service:
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

## Troubleshooting

### Website Not Loading
1. Check if containers are running: `docker ps`
2. Check logs: `make logs`
3. Ensure port 443 is not used by another service

### Database Connection Issues
1. Check MariaDB logs: `docker logs mariadb`
2. Verify credentials in `.env` file match
