# https://github.com/docker-library/wordpress
# https://github.com/docker-library/wordpress/blob/master/latest/php8.2/fpm/Dockerfile
# https://conetix.com.au/blog/what-is-a-dockerfile/
# https://www.wordpressdocker.com/
# https://stackoverflow.com/questions/66086184/exec-php-fpm-executable-file-not-found-in-path-unknown
# wp-login.php
# wp-admin.php //ekli değil
# localhost
# wp-admin

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
RUN apt-get update && apt-get -y install \
 wget \
 curl \
 bash \
 php \
 php-cgi \
 php-mysql \
 php-fpm \
 php-pdo \
 php-gd php-cli \
 php-mbstring \
 redis \
 php-redis \
 sendmail \
 && rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get -y install wget php php-fpm php-mysql sendmail


# COPY ./conf/wp-config.php /var/www/html/wp-config.php

#WordPress CLI'ı wp komutuyla çalıştırabilirsiniz. Bu yapı için curl kurulu olması gerekmektedir.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
# 	&& chmod +x /usr/local/bin/wp \
# 	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN mkdir /run/php

COPY ./tools/create-wp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/create-wp.sh

ENTRYPOINT ["/usr/local/bin/create-wp.sh"]

# nginx'in standart dizinini gösterince artık nginx default olarak değil wordpress ile çalışacaktır.
WORKDIR /var/www/html/

# Port 9000'i dışarıya aç
EXPOSE 9000

ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

RUN service php7.3-fpm start

# RUN if [ -f /etc/php/7.3/fpm/pool.d/www.conf ]; then \
# 		sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i 's/^listen =$/listen = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf && \
# 		sed -i '/^\[www\]/ s/$/\nlisten = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf ; \
# 	else \
# 		COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf && \
# 		echo "Copy process..." ; \
# 	fi

# php-fpm serverını başlat
CMD [ "php-fpm7.3", "-F" ]
# CMD [ "php-fpm" ]
# CMD [ "/usr/sbin/php-fpm7.3", "-F" ]
# CMD ["/usr/local/bin/create-wp.sh", "/usr/sbin/php-fpm7.3", "-F"]

# https://wiki.debian.org/WordPress
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# $> find /usr/sbin/php-fpm7.3
# $> find /etc/php/7.3/fpm/pool.d/www.conf

# if you want to check wordpress www.conf file
# while running wordpress image:
#   $> docker exec -it wordpress bash
#   $> cat /etc/php/7.3/fpm/pool.d/www.conf