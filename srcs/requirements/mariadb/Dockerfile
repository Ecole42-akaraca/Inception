# https://github.com/MariaDB/mariadb-docker

FROM debian:buster

# mariadb-server paketi, MariaDB sunucusunu çalıştırmak için gerekli dosyaları içerir ve mariadb-client paketi, MariaDB sunucusuna bağlanmak için gerekli dosyaları içerir.
# RUN apt-get update && apt-get install -y \
# 	mariadb-server \
# 	mariadb-client

RUN apt-get update && apt-get install -y \
	mariadb-server \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

CMD ["/usr/local/bin/mariadb.sh", "mysqld", "--bind-address=0.0.0.0"]