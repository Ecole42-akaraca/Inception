# https://github.com/MariaDB/mariadb-docker

FROM debian:buster

# mariadb-server paketi, MariaDB sunucusunu çalıştırmak için gerekli dosyaları içerir ve mariadb-client paketi, MariaDB sunucusuna bağlanmak için gerekli dosyaları içerir.
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

EXPOSE 3306

# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/create_wp_db.sql /var/www/

# https://stackoverflow.com/questions/32133353/unable-to-connect-to-mysql-database-in-ubuntu
# root kullanıcısında çalıştırılmadığı zaman hata almamak için dosyanın iznini mysql kullanıcısına veriyoruz.
# iki yapıdan birinin açık olması yeterli
#RUN chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /var/www/create_wp_db.sql

# ??
RUN service mysql start && mysql < /var/www/create_wp_db.sql && rm -f /var/www/create_wp_db.sql;

RUN if [ -f /etc/mysql/mariadb.conf.d/50-server.cnf ]; then \
        chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf && \
        sed -i 's/^#port                   = 3306$/port                   = 3306/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
        sed -i 's/^bind-address            = 127.0.0.1$/#bind-address            = 127.0.0.1/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
        echo "File changed..." ; \
	else \
		COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf && \
		chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf && \
		echo "Copy process..." ; \
		#chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf \
	fi

# CMD ["mysqld"]
# MariaDB servisini arka planda başlat
CMD ["mysqld_safe"]

# https://packages.debian.org/buster/mariadb-server
# https://packages.debian.org/buster/mariadb-client
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get install -y mariadb-server mariadb-client
# $> find /etc/mysql/mariadb.conf.d/50-server.cnf

# if you want to check mariadb 50-server.cnf file
# while running mariadb image:
#   $> docker exec -it mariadb bash
#   $> cat /etc/mysql/mariadb.conf.d/50-server.cnf
# https://forums.cpanel.net/threads/mysql-is-ignoring-etc-my-cnf-setting.613215/
