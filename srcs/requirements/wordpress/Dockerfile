# https://github.com/docker-library/wordpress
# https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm/Dockerfile
# https://conetix.com.au/blog/what-is-a-dockerfile/
# https://www.wordpressdocker.com/

# Subjectte Dockerfile için Alpine veya Debian kullanılması önerilmektedir, bu yüzden kararlı olan bir önceki sürüm tercih edilmiştir.
FROM debian:buster

# WordPress'i çalıştırmak için gerekli temel seviye bileşenler. 
#	php8.2-fpm: WordPress'i çalıştırmak için bir web sunucusuna ihtiyacımız olduğundan, php8.2-fpm kullanmanız gerekir.
#		php8.2-fpm'nin bir web sunucusuyla çalışmak üzere tasarlandığı ve php8.2'nin bir web sunucusuyla çalışmak üzere tasarlanmadığı anlamına gelir.
#	php-mysql: PHP'nin MySQL veritabanıyla iletişim kurmasını sağlayan bir uzantıdır.
#	php-curl: PHP'nin HTTP isteklerini gönderip almasını sağlayan bir uzantıdır.
#	php-gd: PHP'nin grafikler oluşturmasını sağlayan bir uzantıdır.
#	php-mbstring: PHP'nin çok dilli metinleri işlemesini sağlayan bir uzantıdır.
#	php-xml: PHP'nin XML belgelerini işlemesini sağlayan bir uzantıdır.
#	php-zip: PHP'nin ZIP dosyalarını işlemesini sağlayan bir uzantıdır.
RUN apt-get update && apt-get install -y \
		php8.2-fpm \
 		php-mysql \
		php-curl \
		php-gd \
		php-mbstring \
		php-xml \
		php-zip

COPY ./conf/wp-config.php /var/www/html/wp-config.php

# Port 9000'i dışarıya aç
EXPOSE 9000

# php-fpm serverını başlat
CMD [ "php-fpm" ]