FROM debian:trixie

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-zip \
    curl \
    && rm -rf /var/lib/apt/lists/*


    # Package         Purpose
    # php7.4-fpm      PHP FastCGI Process Manager
    # php7.4-mysql    MySQL/MariaDB database driver
    # php7.4-curl     HTTP requests (for updates, APIs)
    # php7.4-gd       Image processing
    # php7.4-mbstring Multibyte string handling
    # php7.4-xml      XML parsing
    # php7.4-zip      ZIP file handling (plugin installation)
    # curl            Command-line tool to download files