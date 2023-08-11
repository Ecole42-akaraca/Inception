
FROM debian:buster

# Adminer'in sürümünü belirleyebilirsiniz, örneğin: 4.8.1
ARG ADMINER_VERSION=4.8.1

RUN apt-get update && apt-get -y install wget php php-fpm php-mysql

# Bu komut, Adminer konteynerinin içinde /var/www/html dizinini oluşturur.
RUN mkdir -p /var/www/html

# Adminer adlı veritabanı yönetim aracını indirip kurmayı amaçlar.
# Belirtilen URL'den Adminer'ın belirli bir sürümünü indirir ve bu dosyayı /var/www/html dizinine index.php adıyla kaydeder.
#	Bu adım, Adminer'ı web sunucusunun erişebileceği bir konumda bulundurmayı sağlar.
# 'apt-get purge -y wget' komutu, wget paketini sistemden kaldırmak için kullanılır.
#	Bu adım, indirme işlemi tamamlandıktan sonra wget paketinin artık gerekli olmadığını ve sistemden temizlenmesini sağlar.
# Bu komut dizisi Adminer'ın belirli bir sürümünü indirir, kaydeder, gereksiz paketleri kaldırır ve geçici dosyaları temizler.
#	Bu sayede Adminer'ı çalıştırmak ve kullanmak için gereken temel adımlar gerçekleştirilir.
RUN wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /var/www/html/index.php \
	&& apt-get purge -y wget \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 9000

ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

# Docker konteynerini başlattığınızda PHP-FPM hizmetinin otomatik olarak çalışmasını sağlar.
#	Böylece, konteyner içindeki PHP uygulamaları düzgün şekilde işlenebilir.
# "CMD [ "php-fpm7.3", "-F" ]" yapısı aynı işlemi gerçekleştirdiğinden dolayı bunu kullanmaya gerek kalmıyor.
# Bu dizinin oluşması için: '/run/php/php7.3-fpm.sock'
RUN service php7.3-fpm start

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www_backup.conf

# Kendimiz tarafından oluşturulan www.conf dosyasını test etmek için:
# RUN rm -rf /etc/php/7.3/fpm/pool.d/www.conf

RUN if [ -f /etc/php/7.3/fpm/pool.d/www.conf ]; then \
		sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's|^listen = /run/php/php7.3-fpm.sock$|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf && \
		echo "Configuration updated." ; \
	else \
		cp /etc/php/7.3/fpm/pool.d/www_backup.conf /etc/php/7.3/fpm/pool.d/www.conf && \
		echo "Configuration copied." ; \
	fi

CMD ["php-fpm7.3", "-F"]

################################################################### INFO ####################################################################

### How to find adminer version for debian:buster ###
# https://packages.debian.org/buster/php
# https://askubuntu.com/questions/599921/adminer-none-of-the-supported-php-extensions-mysqli-mysql-pdo-mysql-are-ava
# https://www.appsloveworld.com/docker/100/29/php-fpm-wont-start-from-a-dockerfile

### for adminer helpful sites ###
# https://www.adminer.org/
# https://kinsta.com/blog/adminer/

### what is adminer page ###
# https://localhost/adminer

### How to find adminer config file ###
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# $> find /usr/sbin/php-fpm7.3
# $> find /etc/php/7.3/fpm/pool.d/www.conf

### if you want to check adminer www.conf file ###
# while running adminer image:
#   $> docker exec -it adminer bash
#   $> cat /etc/php/7.3/fpm/pool.d/www.conf

#############################################################################################################################################
