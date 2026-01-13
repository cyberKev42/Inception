FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT ["setup.sh"]