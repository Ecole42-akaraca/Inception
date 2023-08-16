# Subjectte Dockerfile için Alpine veya Debian kullanılması önerilmektedir, bu yüzden kararlı olan bir önceki sürüm tercih edilmiştir.
FROM debian:buster

# WordPress'i çalıştırmak için gerekli temel seviye bileşenler.
#	❓wget: Wordpress'in resmi sürümünü indirmek için kullanılır.
#	❓curl: Wordpress ve diğer web uygulamalarında, dışarıdaki kaynaklara HTTP istekleri yapmak ve bu isteklele veri alışverişi yapmak için kullanılır.
#	vim: Metin düzenleme ve kod yazma için kullanılan, komut satırı tabanlı bir metin düzenleyicisidir.
#	❓bash: Wordpress'e bash kurmak, daha karmaşık veya özelleştirilmiş işlemler gerçekleştirmenizi sağlar.
#	❓php7.3: PHP programlama dilinin bir sürümüdür. PHP, genellikle web geliştirme için kullanılan popüler bir programlama dilidir ve dinamik içerik oluşturma, veritabanı etkileşimi, form işleme, oturum yönetimi gibi çeşitli web tabanlı işlevleri destekler. 
#		PHP, sunucu taraflı bir dildir, yani sunucu üzerinde işlenir ve sonuçlar web tarayıcılarına gönderilir.
#	❓php-cgi: (PHP Common Gateway Interface), PHP betiklerini web sunucularıyla iletişim kurabilen bir arayüzdür.
#		CGI (Common Gateway Interface), web sunucularının dinamik içerik oluşturması için harici programları çalıştırmasına olanak tanır.
#		 Bir web sunucusu (örneğin Apache veya Nginx) ile çalışarak HTTP isteklerini işler.
#	❓php-mysql: PHP'nin MySQL veritabanıyla iletişim kurmasını sağlayan bir uzantıdır.
#	❓php-fpm: (PHP FastCGI Process Manager), PHP betiklerinin yürütülmesi için kullanılan bir yönetim aracıdır.
#		PHP-FPM, FastCGI (Common Gateway Interface) standardını uygulayan ve PHP betiklerini hızlı ve verimli bir şekilde çalıştırmak için optimize edilmiş bir yönetim sistemidir. 
#		FastCGI, web sunucularının dinamik içerik oluşturmak için harici programları çalıştırmasına olanak tanır.
#	❓php-pdo: (PHP Data Objects), PHP programlama dili için bir veritabanı erişim arayüzüdür.
#		PDO, farklı veritabanı sistemlerine erişim sağlamak için kullanılan bir API'dir.
#		Bu API sayesinde, PHP uygulamaları farklı veritabanlarıyla iletişim kurabilir ve veritabanı işlemlerini gerçekleştirebilir.
#	❓php-gd: PHP programlama dilinde grafik işleme ve görüntü manipülasyonu için kullanılan bir kütüphanedir.
#		GD, "Grafiksel Çizim Kütüphanesi" anlamına gelir ve bu kütüphane sayesinde PHP uygulamaları görüntüleri oluşturabilir, düzenleyebilir ve işleyebilir.
#	❓php-cli: PHP'nin komut satırı arabirimini (Command-Line Interface) temsil eder.
#		PHP'nin komut satırında çalıştırılabilen bir betik dili olarak kullanılmasını sağlayan bir özelliktir.
#		PHP kodunu web tarayıcısı olmadan çalıştırmak veya otomasyon, veri işleme ve betik çalıştırma gibi senaryolarda oldukça kullanışlıdır.
#	❓php-mbstring: PHP programlama dilinde çoklu byte karakter dizilerini işlemek için kullanılan bir eklentidir.
#		MB, "Multi-Byte"ın kısaltmasıdır ve bu eklenti sayesinde PHP, çoklu byte karakterlerini (örneğin, UTF-8 kodlamasındaki Unicode karakterleri) doğru bir şekilde işleyebilir.
#	❓'rm -rf /var/lib/apt/lists/*'': Docker imajını oluştururken kullanılan işlem sırasında geçici olarak indirilen APT paket listelerini silmeye yöneliktir.
RUN apt-get update && apt-get install -y \
	wget \
	curl \
	vim \
	bash \
	php7.3 \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd \
	php-cli \
	php-mbstring \
	&& rm -rf /var/lib/apt/lists/*

# Docker imajı oluştururken WordPress komut satırı aracını (WP-CLI) indirip kurmayı hedefler.
#	WP-CLI, WordPress yönetimini komut satırından yapmanızı sağlayan bir araçtır.
# İndirilen WP-CLI PHAR dosyasına çalıştırma izni verilir.
#	Bu, dosyanın komut satırında çalıştırılabilir hale gelmesini sağlar.
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
	&& chmod +x /usr/local/bin/wp \
	&& rm -rf /var/lib/apt/lists/*

# Yedek olarak tutulan bir konfigürasyon dosyasıdır.
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www_backup.conf

# Bu dizin, PHP-FPM (FastCGI Process Manager) tarafından çalışma zamanında oluşturulan soket dosyaları ve diğer geçici dosyalar için kullanılır.
# WordPress Docker imajında bu komutu kullanmanızın nedeni, PHP-FPM'nin düzgün çalışabilmesi için gerekli dizin yapısını oluşturmak ve imajın çalışma zamanında PHP-FPM'nin gereksinim duyduğu yapıları içermesini sağlamaktır.
#	Bu, WordPress uygulamasının hızlı ve stabil bir şekilde çalışmasını sağlamak için önemlidir.
RUN mkdir -p /run/php

# Docker imajının içine belirli bir betik dosyasını yerleştirmenizi sağlar.
COPY ./tools/create_wp.sh /usr/local/bin/

# Belirli bir betik dosyasına çalıştırma izni vermek için kullanılır. 
RUN chmod +x /usr/local/bin/create_wp.sh

# Docker imajının çalışma dizinini belirler.
#	Çalışma dizini, Docker konteyneri içindeki komutların ve işlemlerin çalışacağı varsayılan dizini ifade eder.
WORKDIR /var/www/html/

# Docker imajında bir konteynerin 9000 numaralı ağ portunu dış dünyaya açık hale getirdiğini belirtir.
#	Bu, diğer servisler veya sunucular bu port üzerinden Docker konteyneri ile iletişim kurabilir.
EXPOSE 9000

# Docker imajında kullanılan bir ortam değişkenini tanımlar.
#	Bu, konteyner içinde PHP-FPM 7.3'ün çalıştırılabilir dosyalarına erişiminizi sağlar.
#	Böylece, PHP-FPM komutlarını doğrudan komut satırında veya betiklerde kullanabilirsiniz.
ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

# Docker konteynerini başlattığınızda PHP-FPM hizmetinin otomatik olarak çalışmasını sağlar.
#	Böylece, konteyner içindeki PHP uygulamaları düzgün şekilde işlenebilir.
# "CMD [ "php-fpm7.3", "-F" ]" yapısı aynı işlemi gerçekleştirdiğinden dolayı bunu kullanmaya gerek kalmıyor.
# RUN service php7.3-fpm start

# Kendimiz tarafından oluşturulan www.conf dosyasını test etmek için:
# RUN rm -rf /etc/php/7.3/fpm/pool.d/www.conf

# /etc/php/7.3/fpm/pool.d/www.conf dosyasının varlığını kontrol eder.
#	'sed' komutları ile www.conf dosyasındaki bazı satırları değiştirir.
#	PHP-FPM'nin kullanıcı ve grup ayarları, dinleme soketi ve izinleri ayarlanmış olur.
#	❓'user = www-data': PHP-FPM hizmetinin hangi kullanıcı adı altında çalışacağını belirler.
#		'www-data', genellikle web sunucularının (örneğin, Nginx) çalıştığı kullanıcı adını ifade eder.
#		Web sunucuları genellikle daha düşük güvenlik riskleri taşıyan ve sınırlı izinlere sahip ayrı bir kullanıcı hesabı altında çalışır.
#		Bu şekilde, web sunucusunun potansiyel güvenlik açıklarından kaynaklanan riskleri minimize etmek amaçlanır.
#		Dolayısıyla, 'user = www-data' ayarı, PHP-FPM'nin bu kullanıcı adı altında çalışacağını belirtir ve böylece PHP-FPM'nin güvenlik açısından daha izole bir şekilde çalışmasını sağlar.
#	❓'group = www-data': 'user = www-data' ile benzer bir durum söz konusudur lakin bu durum grup yapısını ifade eder.
#	❓'listen = 9000': Bu ayar, PHP-FPM hizmetinin hangi port veya soket üzerinden gelen istekleri dinleyeceğini belirler.
#		Bu port numarası genellikle 9000 olarak belirlenir, çünkü bu, PHP-FPM'nin varsayılan olarak dinlemesi gereken bir porttur.
#		Web sunucusu (örneğin, Nginx veya Apache), belirtilen port üzerinden PHP-FPM'ye istekleri iletecektir.
#		Buradaki port ayarı PHP-FPM'nin hangi portu dinleyeceğini belirlerken, Dockerfile'daki EXPOSE komutu Docker konteynerinin hangi portunun dış dünyaya açılacağını belirtir.
#		Her iki ayar da farklı amaçlar için kullanılır ve birbirlerine bağlı değildir.
#	❓'listen.owner = www-data': Bu ayar, PHP-FPM hizmetinin hangi kullanıcı hesabı altında dinleme soketi veya portunu oluşturacağını belirtir.
#	❓'listen.group = www-data': 'owner' ile aynı yapıdadır sadece group yapısını temsil eder.
#	❓'listen.mode = 660': Bu ayar, PHP-FPM hizmetinin dinleme soketi veya portunu oluştururken hangi dosya izinlerini kullanacağını belirtir.
#		İlk rakam olan '0' kullanıcı (owner) izinlerini belirtir.
#		İkinci rakam olan '6' grup (group) izinlerini belirtir.
#			'6' sekizli sayı sisteminde 'rw-'' izinleri anlamına gelir, yani okuma ve yazma izinlerini ifade eder.
#		Üçüncü rakam olan '0' diğer (others) izinlerini belirtir.
RUN if [ -f /etc/php/7.3/fpm/pool.d/www.conf ]; then \
		sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's|^listen = /run/php/php7.3-fpm.sock$|listen = 9000|' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
		sed -i 's/^;listen.mode = 0660$/listen.mode = 660/' /etc/php/7.3/fpm/pool.d/www.conf && \
		echo "Configuration updated." ; \
	else \
		cp /etc/php/7.3/fpm/pool.d/www_backup.conf /etc/php/7.3/fpm/pool.d/www.conf && \
		echo "Configuration copied." ; \
	fi

# Docker konteyneri çalıştırıldığında otomatik olarak başlatılacak komut veya betiği belirtir.
#	Yani bu ifade, Docker konteyneri başlatıldığında "create_wp.sh" adlı betiğin çalıştırılmasını sağlar.
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

# Docker konteyneri çalıştırıldığında otomatik olarak çalıştırılacak komutu belirtir.
#	PHP-FPM (FastCGI Process Manager) servisinin belirli bir PHP sürümüyle çalıştırılmasını sağlar. 
#	'-F' bayrağı ise PHP-FPM'i "foreground" (arka planda değil, ön planda) çalıştırmak için kullanılır.
#		Yani bu ifade, Docker konteyneri başlatıldığında PHP-FPM servisinin belirli bir sürümü olan php-fpm7.3'ün konteyner içerisinde ön planda çalıştırılmasını sağlar.
# 	Bu şekilde Docker konteyneri çalıştırıldığında PHP-FPM servisi başlatılır ve belirli bir PHP sürümüyle HTTP isteklerini işlemeye başlar.
# 'RUN service php7.3-fpm start' işleminin aynısı burada da gerçekleştiğinden doları RUN yapısına gerek kalınmıyor.
CMD [ "php-fpm7.3", "-F" ]

################################################################### INFO ####################################################################

### How to find wordpress version for debian:buster ###
# https://packages.debian.org/buster/wordpress

### for wordpress helpful sites ###
# https://conetix.com.au/blog/what-is-a-dockerfile/
# https://www.wordpressdocker.com/
# https://stackoverflow.com/questions/66086184/exec-php-fpm-executable-file-not-found-in-path-unknown

### what are wordpress pages ###
# https://localhost/wp-login.php
# Before accessing the wp-admin page, you must login from the wp-login page.
# https://localhost/wp-admin

### nginx return error '502 bad gateway' ###
# If there is an error when the services are started, it means that wordpress has not created the users yet.

### How to find wordpress www.conf file ###
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# $> find /usr/sbin/php-fpm7.3
# $> find /etc/php/7.3/fpm/pool.d/www.conf

### How to find wordpress config file ###
# $> docker pull wordpress
# $> docker run -it wordpress

### latest wordpress pull and check ###
# $> docker pull wordpress
# $> docker run --name some-wordpress -p 8080:80 -d wordpress
# $> docker exec -it some-wordpress bash

### WordPress container'ı için kullanılabilecek bazı tools dosyaları şunlardır ###
# wp-cli.sh - WordPress komut satırı arayüzünün (CLI) bir kabuk betiğidir.
#	Bu dosya, WordPress'in CLI'sını kullanarak WordPress sitenizi yönetmenizi sağlar.
# wp-config.php - WordPress'in en önemli dosyalarından biridir.
#	WordPress'in veritabanını, şifreleme ayarlarını ve diğer önemli ayarları içerir.
# wp-includes - WordPress'in dahili dosyalarının bulunduğu dizindir.
#	Bu dizinde, WordPress'in temel işlevlerini sağlayan PHP dosyaları bulunur.
# wp-content - WordPress'in içeriğinin bulunduğu dizindir.
#	Bu dizinde, WordPress temaları, eklentileri ve yazılar bulunur.
# wp-admin - WordPress yönetim panelinin bulunduğu dizindir.
#	Bu dizinde, WordPress sitenizi yönetmek için kullanabileceğiniz araçlar bulunur.
# Bu dosyalar, WordPress containerı oluşturmak ve yönetmek için gereklidir.

### WordPress container'ı için kullanılabilecek bazı config dosyaları şunlardır ###
# docker-compose.yml - Docker Compose'in ana yapılandırma dosyasıdır.
#	Bu dosya, Docker Compose'in bir veya daha fazla konteynırı nasıl oluşturacağını ve başlatacağını tanımlar.
# wp-config.php - WordPress'in en önemli dosyalarından biridir.
#	WordPress'in veritabanını, şifreleme ayarlarını ve diğer önemli ayarları içerir.
# nginx.conf - Nginx web sunucusunun yapılandırma dosyasıdır.
#	Bu dosya, Nginx web sunucusunun nasıl çalışacağını tanımlar.
# php.ini - PHP'nin yapılandırma dosyasıdır.
#	Bu dosya, PHP'nin nasıl çalışacağını tanımlar.
# Bu dosyalar, WordPress containerı oluşturmak ve yönetmek için gereklidir.

### WordPress mariadb ile nasıl bağlantı kuruyor ###
# WordPress ve MariaDB servisleri birbirleriyle doğrudan haberleşerek çalışır.
# WordPress, MariaDB veritabanına bağlanarak veritabanı işlemlerini gerçekleştirir.
# WordPress, MariaDB ile iletişim kurmak için MariaDB’nin dinlediği 3306 portunu kullanır.
#	Bu sayede, WordPress veritabanına veri yazabilir veya veritabanından veri okuyabilir. Ancak, bu işlemin gerçekleşebilmesi için, konteynerlerin aynı Docker ağına bağlı olmaları ve MariaDB konteynerinin adının WordPress konteynerindeki ayarlarda doğru bir şekilde belirtilmiş olması gerekir.
# Konteynerler, docker-compose.yml dosyasında belirtilen servis adlarını kullanarak birbirleriyle iletişim kurabilirler.
#	Örneğin, bir WordPress servisi, docker-compose.yml dosyasında belirtilen MariaDB servisinin adını kullanarak MariaDB’ye bağlanabilir.
# WordPress'in kurulumunda DB_HOST olarak wp-config.php dosyasında mariadb yazdığı için mariadb servisi ile bağlantı kurabilmektedir.
#	Eğerki bu host bilgisi olmasaydı "error establishing a database connection" hatası alınırdı.

#############################################################################################################################################
