#!/bin/bash

# stop script if something fails
set -e

# create socket directory
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# check if this is the first run (database not initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# check if database exists and set up user if not
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Starting temporary MariaDB server..."
    mysqld --user=mysql &
    
    # wait for MariaDB to be ready
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

    # stop temporary server
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql