# https://www.adminer.org/
# https://kinsta.com/blog/adminer/

FROM debian:buster

# Adminer'in sürümünü belirleyebilirsiniz, örneğin: 4.8.1
ARG ADMINER_VERSION=4.8.1

RUN apt-get update && apt-get -y install wget php php-fpm

# Adminer'i indirip /var/www/html klasörüne kopyalıyoruz
RUN mkdir -p /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /var/www/html/adminer.php \
    && apt-get purge -y wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

# RUN if [ -f /conf/www.conf ]; then \
#         COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf \
#         echo "Copy process..." ; \
    # else \
    #     sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
    #     sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
    #     sed -i 's/^listen =$/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf && \
    #     sed -i 's/^listen =$/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf && \
    #     sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
    #     sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf ; \
    # fi

# RUN sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
# RUN sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
# RUN sed -i 's/^listen =$/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf
# RUN sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
# RUN sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf
# RUN sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf

# https://www.appsloveworld.com/docker/100/29/php-fpm-wont-start-from-a-dockerfile
RUN service php7.3-fpm start
# RUN service php7.3-fpm enable
# RUN service php7.3-fpm status
# Bu dizinin oluşması için: '/run/php/php7.3-fpm.sock'

CMD ["php-fpm7.3", "-F"]

# CMD ["/usr/sbin/php-fpm7.3", "-F"]

# https://packages.debian.org/buster/php
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# $> find /usr/sbin/php-fpm7.3
# $> find /etc/php/7.3/fpm/pool.d/www.conf

# if you want to check adminer www.conf file
# while running adminer image:
#   $> docker exec -it adminer bash
#   $> cat /etc/php/7.3/fpm/pool.d/www.conf
