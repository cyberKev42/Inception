FROM debian:trixie

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php \
    && sed -i 's|listen = /run/php/php.*-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf

COPY tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["setup.sh"]


    # Package         Purpose
    # php7.4-fpm      PHP FastCGI Process Manager
    # php7.4-mysql    MySQL/MariaDB database driver
    # php7.4-curl     HTTP requests (for updates, APIs)
    # php7.4-gd       Image processing
    # php7.4-mbstring Multibyte string handling
    # php7.4-xml      XML parsing
    # php7.4-zip      ZIP file handling (plugin installation)
    # curl            Command-line tool to download files