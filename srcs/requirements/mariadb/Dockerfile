# https://github.com/MariaDB/mariadb-docker

FROM debian:buster

# mariadb-server paketi, MariaDB sunucusunu çalıştırmak için gerekli dosyaları içerir ve mariadb-client paketi, MariaDB sunucusuna bağlanmak için gerekli dosyaları içerir.
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/create_wp_db.sql /var/www/

# https://stackoverflow.com/questions/32133353/unable-to-connect-to-mysql-database-in-ubuntu
# root kullanıcısında çalıştırılmadığı zaman hata almamak için dosyanın iznini mysql kullanıcısına veriyoruz.
# iki yapıdan birinin açık olması yeterli
#RUN chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start && mysql < /var/www/create_wp_db.sql && rm -f /var/www/create_wp_db.sql

# CMD ["mysqld"]
# MariaDB servisini arka planda başlat
CMD ["mysqld_safe"]