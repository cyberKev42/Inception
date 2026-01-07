#!/bin/bash

set -e

# Create socket directory
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Check if this is first run (database not initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Check if our database exists (if not, we need to set up users)
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql &
    
    # Wait for MariaDB to be ready
    until mysqladmin ping --silent 2>/dev/null; do
        sleep 1
    done
    
    echo "Creating database and users..."
    mysql -u root << EOF
-- Create WordPress database
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Create WordPress user with access from any host in Docker network
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

    echo "Database setup complete."
    
    # Stop temporary server
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql