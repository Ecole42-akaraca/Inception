# https://www.adminer.org/
# https://kinsta.com/blog/adminer/

FROM debian:buster

# RUN curl -o https://github.com/vrana/adminer/releases/download/v4.7.8/adminer-4.7.8.php

# Adminer'in sürümünü belirleyebilirsiniz, örneğin: 4.8.1
ARG ADMINER_VERSION=4.8.1

RUN apt-get update && apt-get -y install wget php php-fpm

# rm -rf /var/lib/apt/lists/*

# Adminer'i indirip /var/www/html klasörüne kopyalıyoruz
RUN mkdir -p /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /var/www/html/adminer.php \
    && apt-get purge -y wget

# COPY /conf/www.conf /etc/php8/php-fpm.d/www.conf

EXPOSE 9000

ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

RUN sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/^listen =$/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf

RUN service php7.3-fpm start
# RUN service php7.3-fpm enable
# RUN service php7.3-fpm status
# Bu dizinin oluşması için: '/run/php/php7.3-fpm.sock'

CMD ["php-fpm7.3", "-F"]

# CMD ["/usr/sbin/php-fpm7.3", "-F"]

# https://packages.debian.org/buster/php
# docker pull debian
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# find /usr/sbin/php-fpm7.3
# find /etc/php/7.3/fpm/pool.d/www.conf

