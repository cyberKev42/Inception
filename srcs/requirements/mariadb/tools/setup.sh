#!/bin/bash

# stop script if something fails
set -e

# check if this is the first run (database not initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Create init file if database doesn't exist
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Creating initialization file..."
    cat > /tmp/init.sql << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    
    echo "Starting MariaDB server with initialization..."
    exec mysqld --user=mysql --init-file=/tmp/init.sql
else
    echo "Starting MariaDB server..."
    exec mysqld --user=mysql
fi