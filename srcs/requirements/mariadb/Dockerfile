# https://github.com/MariaDB/mariadb-docker

FROM debian:buster

# mariadb-server paketi, MariaDB sunucusunu çalıştırmak için gerekli dosyaları içerir ve mariadb-client paketi, MariaDB sunucusuna bağlanmak için gerekli dosyaları içerir.
RUN apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-client

EXPOSE 3306

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY create_database.sql /var/www/

RUN service mysql start && mysql < /var/www/create_database.sql && rm -f /var/www/create_database.sql;

CMD ["mysqld"]