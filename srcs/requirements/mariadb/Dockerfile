
FROM debian:buster

# MariaDB sunucusunu ve istemcisini konteyner içinde kurar.
# mariadb-server paketi, MariaDB sunucusunu çalıştırmak için gerekli dosyaları içerir ve mariadb-client paketi, MariaDB sunucusuna bağlanmak için gerekli dosyaları içerir.
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

# "3306" port numarası, MariaDB veritabanı sunucusunun varsayılan iletişim portu olarak kullanıldığı yerdir.
EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server_backup.cnf
COPY ./tools/create_wp_db.sql /var/www/

RUN chmod +x /var/www/create_wp_db.sql

# MariaDB'nin Dockerfile içinde çalıştırılmasını sağlar ve bir SQL dosyasını veritabanına yükler.
#	'service mysql start': MariaDB sunucusunun Docker konteyneri içinde başlatılmasını sağlar.
#	'mysql < /var/www/create_wp_db.sql': SQL dosyasını MariaDB sunucusuna yükler.
#		Dosyanın içeriği MariaDB tarafından işlenir ve içindeki SQL komutları veritabanı üzerinde çalıştırılır.
#		Bu adımda, genellikle veritabanının yapısını ve başlangıç verilerini tanımlayan SQL komutları bulunur.
#	'rm -f /var/www/create_wp_db.sql': Yüklenen SQL dosyasını siler.
#		SQL dosyası artık sunucuda gereksiz olduğu için silinir.
RUN service mysql start && mysql < /var/www/create_wp_db.sql && rm -f /var/www/create_wp_db.sql;

# Kendimiz tarafından oluşturulan 50-server.cnf dosyasını test etmek için:
# RUN rm -rf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN if [ -f /etc/mysql/mariadb.conf.d/50-server.cnf ]; then \
		chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf && \
		sed -i 's/^user.*$/user                    = root/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
		sed -i 's/^#port.*$/port                    = 3306/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
		sed -i 's/^bind-address.*$/bind-address                    = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
		echo "Configuration updated." ; \
	else \
		cp /etc/mysql/mariadb.conf.d/50-server_backup.cnf /etc/mysql/mariadb.conf.d/50-server.cnf && \
		chmod 600 /etc/mysql/mariadb.conf.d/50-server.cnf && \
		echo "Configuration copied." ; \
	fi

# Konteyner başlatıldığında, MariaDB sunucusunu güvenli bir şekilde başlatmak için mysqld_safe komutunu çalıştırır.
#	MariaDB sunucusunun düzgün başlamasını ve çökmeleri azaltmayı amaçlar.
#	Yapılandırma dosyalarının hatalarını yakalar, disk alanı gibi temel kaynakların uygunluğunu kontrol eder ve sunucunun düzgün çalışabilmesi için gerekli önkoşulları kontrol eder.
#	Eğer MariaDB sunucusu çökerse, "mysqld_safe" komutu çökmeyi ele alabilir ve sunucunun yeniden başlatılmasını sağlayabilir.
#		Bu, veritabanı hizmetinin sürekliliğini korumaya yardımcı olabilir.
#	Olası hataların ve güvenlik ihlallerinin tespit edilmesine ve ele alınmasına yardımcı olabilir.
CMD ["mysqld_safe"]

################################################################### INFO ####################################################################

### for mariadb helpful sites ###
# https://github.com/MariaDB/mariadb-docker/blob/master/10.5/Dockerfile
# https://hub.docker.com/_/mariadb
# https://forums.cpanel.net/threads/mysql-is-ignoring-etc-my-cnf-setting.613215/
# https://mariadb.com/kb/en/creating-a-custom-container-image/
# https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/

# /docker-entrypoint-initdb.d/ : MariaDB Docker imajında özel bir konumdur ve bu dizine kopyalanan SQL dosyaları, MariaDB sunucusu başlatıldığında otomatik olarak çalıştırılır.
# SQL dosyanızı bir MariaDB Docker dosyasındaki /docker-entrypoint-initdb.d/ dizinine kopyalarsanız, RUN service mysql start && mysql < /var/www/create_wp_db.sql && rm -f /var/www/create_wp_db.sql; komutunu çalıştırmanız gerekmez.
#	Bunun nedeni, /docker-entrypoint-initdb.d/ dizinindeki herhangi bir .sh veya .sql dosyasının, kapsayıcı ilk kez başlatıldığında otomatik olarak yürütülecek olmasıdır. 

### How to find mariadb version for debian:buster ###
# https://packages.debian.org/buster/mariadb-server
# https://packages.debian.org/buster/mariadb-client

### How to find mariadb 50-server.cnf file ###
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get install -y mariadb-server mariadb-client
# $> find /etc/mysql/mariadb.conf.d/50-server.cnf

### How to check when mariadb config files are running ###
# while running mariadb image:
#	$> docker exec -it mariadb bash
#	$> cat /etc/mysql/mariadb.conf.d/50-server.cnf

#############################################################################################################################################
