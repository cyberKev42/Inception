#!/bin/bash

# stop if anything fails
set -e

# wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
TIMEOUT=60
COUNT=0
while ! mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" &>/dev/null; do
    if [ $COUNT -ge $TIMEOUT ]; then
        echo "ERROR: MariaDB did not become ready in time"
        exit 1
    fi
    sleep 2
    COUNT=$((COUNT + 2))
done
echo "MariaDB is ready!"

# go to wordpress directory
cd /var/www/html

# download wordpress if not present
if [ ! -f "wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb:3306 \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    echo "Creating additional user..."
    wp user create \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --allow-root

    echo "WordPress installation complete!"
fi

echo "Starting PHP-FPM..."
exec php-fpm8.4 -F