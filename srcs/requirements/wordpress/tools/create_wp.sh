#!/bin/sh

# if yapısında komut olarak algılanması için, '[]' ifadesi içinde her iki taraftanda en az bir adet boşluk bırakılmalıdır.
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded!"
else

	# WordPress'i temiz bir şekilde yeniden kurmak veya güncellemek istendiğinde kullanılır.
	# Bu dizinler, WordPress'in çekirdek dosyalarını, eklentileri, temaları ve diğer içerikleri içerir.
	rm -rf wp-admin wp-content wp-includes

	# WordPress'in en son sürümünü indirip kurmaya yönelik adımları içerir.
	#	İndirilen dosya açılır ve WordPress dosyaları betiğin bulunduğu dizine taşınır.
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	# WordPress'in yapılandırma dosyasını (wp-config.php) düzenlemek ve özelleştirmek için kullanılır.
	#	`wp-config-sample.php` dosyasındaki veritabanı ayarları, betiğe verilen ortam değişkenleri ile değiştirilir.
	#	`wp-config-sample.php` dosyası `wp-config.php` olarak kopyalanır.
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	sed -i "/<?php/a define('WP_SITEURL', $DOMAIN_NAME);\ndefine('WP_HOME', $DOMAIN_NAME);" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	# Bu yapı olmaz ise WordPress'in kurulum sihirbazı gelecektir.
	# WordPress'in çekirdek kurulumunu ve kullanıcıları oluşturmayı gerçekleştiriyor.
	echo "wordpress creating users..."
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL};
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	echo "wordpress set up!"
	# Bu işlemler tamamlandıktan sonra, WordPress kurulumu tamamlanmış olur.

fi

exec "$@"

################################################################### INFO ####################################################################

### for wordpress helpful sites ###
# https://www.serverkaka.com/2018/12/install-and-configure-latest-wordpress-ubuntu.html
# https://developer.wordpress.org/advanced-administration/wordpress/wp-config/

### how to find wp-config-sample.php file ###
# $> docker pull wordpress
# $> docker run -it wordpress
# find /var/www/html/wp-config-sample.php
# find /var/www/html/wp-config.php

# grep -r "example.com" .
# grep -r "akaraca.42.fr" .

#############################################################################################################################################
