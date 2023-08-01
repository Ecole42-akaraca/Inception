FROM debian:buster

# RUN curl -o https://github.com/vrana/adminer/releases/download/v4.7.8/adminer-4.7.8.php

# Adminer'in sürümünü belirleyebilirsiniz, örneğin: 4.8.1
ARG ADMINER_VERSION=latest

RUN apt-get update && apt-get -y install \
	wget

# Adminer'i indirip /var/www/html klasörüne kopyalıyoruz

RUN mkdir /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /var/www/html/adminer.php \
    && apt-get purge -y wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

CMD ["php-fpm", "-F"]
