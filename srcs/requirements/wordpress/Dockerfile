# https://github.com/docker-library/wordpress
# https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm/Dockerfile
# https://conetix.com.au/blog/what-is-a-dockerfile/
# https://www.wordpressdocker.com/
# https://stackoverflow.com/questions/66086184/exec-php-fpm-executable-file-not-found-in-path-unknown

# Subjectte Dockerfile için Alpine veya Debian kullanılması önerilmektedir, bu yüzden kararlı olan bir önceki sürüm tercih edilmiştir.
FROM debian:buster

# WordPress'i çalıştırmak için gerekli temel seviye bileşenler. 
#	php8.2-fpm: WordPress'i çalıştırmak için bir web sunucusuna ihtiyacımız olduğundan, php8.2-fpm kullanmanız gerekir.
#		php8.2-fpm'nin bir web sunucusuyla çalışmak üzere tasarlandığı ve php8.2'nin bir web sunucusuyla çalışmak üzere tasarlanmadığı anlamına gelir.
#		php8.2 ve php8.2-fpm debian içinde yok bu yüzden php7.3 kurdum
#	php-mysql: PHP'nin MySQL veritabanıyla iletişim kurmasını sağlayan bir uzantıdır.
#	php-curl: PHP'nin HTTP isteklerini gönderip almasını sağlayan bir uzantıdır.
#	php-gd: PHP'nin grafikler oluşturmasını sağlayan bir uzantıdır.
#	php-mbstring: PHP'nin çok dilli metinleri işlemesini sağlayan bir uzantıdır.
#	php-xml: PHP'nin XML belgelerini işlemesini sağlayan bir uzantıdır.
#	php-zip: PHP'nin ZIP dosyalarını işlemesini sağlayan bir uzantıdır.
RUN apt-get update && apt-get install -y \
		php7.3 \
 		php-mysql \
		php-curl \
		php-gd \
		php-mbstring \
		php-xml \
		php-zip \
		php-fpm

COPY ./conf/wp-config.php /var/www/html/wp-config.php

RUN yum --enablerepo=remi-php73 -y install php php-bcmath php-cli php-common php-gd php-intl php-ldap php-mbstring \
    php-mysqlnd php-pear php-soap php-xml php-xmlrpc php-zip php-fpm

# Port 9000'i dışarıya aç
EXPOSE 9000

# php-fpm serverını başlat
CMD [ "php-fpm" ]
# CMD [ "/usr/sbin/php-fpm7.3", "--nodaemonize" ]