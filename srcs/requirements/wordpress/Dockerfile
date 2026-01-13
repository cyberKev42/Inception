FROM debian:bookworm

# install basic php tools
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

# edit the config file to listen to tcp port 9000 (standard convention for PHP-FPM)
RUN mkdir -p /run/php && sed -i 's|listen = /run/php/php.*-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/*/fpm/pool.d/www.conf

COPY tools/setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["setup.sh"]
