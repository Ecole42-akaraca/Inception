#!/bin/sh

# Check if wp-config.php exist.
if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded!"
else

####### MANDATORY PART ##########

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
###################################

####### BONUS PART ################

## redis ##

	wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
	wp config set WP_REDIS_PORT 6379 --raw --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	#wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root

###  end of redis part  ###

###################################
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

# `BONUS PART` bölümünde ise, Redis önbellekleme eklentisi etkinleştirilir. Bu bölümde aşağıdaki işlemler yapılır:
# 1. Redis ayarları yapılandırılır.
# 2. Redis önbellekleme eklentisi indirilir ve etkinleştirilir.
# 3. Tüm eklentiler güncellenir.
# 4. Redis önbellekleme eklentisi etkinleştirilir.
# Bu işlemler tamamlandıktan sonra, WordPress kurulumu Redis önbellekleme eklentisi ile çalışır hale gelmiş olur.

# `wp` komutu, WordPress için bir komut satırı aracıdır. Bu betikte kullanılan `wp` komutları aşağıdaki işlemleri yapar:
# - `wp config set WP_REDIS_HOST redis --allow-root`: WordPress yapılandırma dosyasına (`wp-config.php`) `WP_REDIS_HOST` sabitini ekler ve değerini `redis` olarak ayarlar. Bu ayar, Redis sunucusunun konumunu belirtir.
# - `wp config set WP_REDIS_PORT 6379 --raw --allow-root`: WordPress yapılandırma dosyasına (`wp-config.php`) `WP_REDIS_PORT` sabitini ekler ve değerini `6379` olarak ayarlar. Bu ayar, Redis sunucusunun dinlediği port numarasını belirtir.
# - `wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root`: WordPress yapılandırma dosyasına (`wp-config.php`) `WP_CACHE_KEY_SALT` sabitini ekler ve değerini betiğe verilen `$DOMAIN_NAME` ortam değişkeni ile ayarlar. Bu ayar, önbellek anahtarlarının benzersizliğini sağlamak için kullanılır.
# - `wp config set WP_REDIS_CLIENT phpredis --allow-root`: WordPress yapılandırma dosyasına (`wp-config.php`) `WP_REDIS_CLIENT` sabitini ekler ve değerini `phpredis` olarak ayarlar. Bu ayar, Redis istemcisi olarak kullanılacak PHP eklentisini belirtir.
# - `wp plugin install redis-cache --activate --allow-root`: Redis önbellekleme eklentisini indirir ve etkinleştirir.
# - `wp plugin update --all --allow-root`: Tüm eklentileri günceller.
# - `wp redis enable --allow-root`: Redis önbellekleme eklentisini etkinleştirir.
# Bu komutlar, WordPress kurulumunu Redis önbellekleme eklentisi ile çalışacak şekilde yapılandırır. Bu sayede, WordPress sayfaları Redis önbelleğinde saklanarak daha hızlı bir şekilde sunulabilir.


# EN
# This script installs WordPress and enables the Redis caching plugin.

# In the `MANDATORY PART` section, the following actions are performed:
# 1. The latest version of WordPress is downloaded.
# 2. The downloaded file is extracted and the WordPress files are moved to the directory where the script is located.
# 3. The database settings in the `wp-config-sample.php` file are replaced with the environment variables passed to the script.
# 4. The `wp-config-sample.php` file is copied as `wp-config.php`.
# After these actions are completed, the WordPress installation is complete.

# In the `BONUS PART` section, the Redis caching plugin is enabled. In this section, the following actions are performed:
# 1. Redis settings are configured.
# 2. The Redis caching plugin is installed and activated.
# 3. All plugins are updated.
# 4. The Redis caching plugin is enabled.
# After these actions are completed, the WordPress installation is ready to work with the Redis caching plugin.

# The `wp` command is a command line interface for WordPress. The `wp` commands used in this script perform the following actions:
# - `wp config set WP_REDIS_HOST redis --allow-root`: Adds the `WP_REDIS_HOST` constant to the WordPress configuration file (`wp-config.php`) and sets its value to `redis`. This setting specifies the location of the Redis server.
# - `wp config set WP_REDIS_PORT 6379 --raw --allow-root`: Adds the `WP_REDIS_PORT` constant to the WordPress configuration file (`wp-config.php`) and sets its value to `6379`. This setting specifies the port number that the Redis server is listening on.
# - `wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root`: Adds the `WP_CACHE_KEY_SALT` constant to the WordPress configuration file (`wp-config.php`) and sets its value to the `$DOMAIN_NAME` environment variable passed to the script. This setting is used to ensure uniqueness of cache keys.
# - `wp config set WP_REDIS_CLIENT phpredis --allow-root`: Adds the `WP_REDIS_CLIENT` constant to the WordPress configuration file (`wp-config.php`) and sets its value to `phpredis`. This setting specifies the PHP extension to use as a Redis client.
# - `wp plugin install redis-cache --activate --allow-root`: Installs and activates the Redis caching plugin.
# - `wp plugin update --all --allow-root`: Updates all plugins.
# - `wp redis enable --allow-root`: Enables the Redis caching plugin.
# These commands configure the WordPress installation to work with the Redis caching plugin. This allows WordPress pages to be stored in Redis cache and served faster.