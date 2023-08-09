#!/bin/sh
# https://www.serverkaka.com/2018/12/install-and-configure-latest-wordpress-ubuntu.html

# Check if wp-config.php exist.
# if yapısını boşluklarla ayır yoksa komut olarak algılamayabilir.
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded!"
else

	rm -rf wp-admin wp-content wp-includes

	#Download wordpress and all config file
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	#Inport env variables in the config file
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	# bu yapı olmaz ise wordpressin kurulum sihirbazı gelecektir.
	# WordPress'in çekirdek kurulumunu ve kullanıcıları oluşturmayı gerçekleştiriyor.
	echo "wordpress creating users..."
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL};
	wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD};
	echo "wordpress set up!"

fi

exec "$@"

# NOTES:

# TR
# Bu betik, WordPress kurulumu yapar ve Redis önbellekleme eklentisini etkinleştirir.

# `MANDATORY PART` bölümünde, aşağıdaki işlemler yapılır:
# 1. WordPress'in en son sürümü indirilir.
# 2. İndirilen dosya açılır ve WordPress dosyaları betiğin bulunduğu dizine taşınır.
# 3. `wp-config-sample.php` dosyasındaki veritabanı ayarları, betiğe verilen ortam değişkenleri ile değiştirilir.
# 4. `wp-config-sample.php` dosyası `wp-config.php` olarak kopyalanır.
# Bu işlemler tamamlandıktan sonra, WordPress kurulumu tamamlanmış olur.


# EN
# This script installs WordPress and enables the Redis caching plugin.

# In the `MANDATORY PART` section, the following actions are performed:
# 1. The latest version of WordPress is downloaded.
# 2. The downloaded file is extracted and the WordPress files are moved to the directory where the script is located.
# 3. The database settings in the `wp-config-sample.php` file are replaced with the environment variables passed to the script.
# 4. The `wp-config-sample.php` file is copied as `wp-config.php`.
# After these actions are completed, the WordPress installation is complete.
