# Subject: Container'lar Alpine veya Debian'ın sondan bir önceki kararlı sürümünden oluşturulmalıdır.
# Debian'nın sondan bir önceki olan kararlı sürümü buster'dır(Buster, sürümün adıdır yani v10).
# 'FROM debian:buster': Image'ın temel olarak Debian(buster) tabanlı bir image'dan oluşturulacağını belirtir.
FROM debian:buster

# 'RUN apt-get update && apt-get install -y nginx openssl': Image'de çalıştırılacak komutları belirtir.
# 	İlk olarak, paket yöneticisi apt-get ile paket listesi güncellenir ve ardından Nginx ve OpenSSL paketleri yüklenir.
RUN apt-get update && apt-get install -y nginx openssl

# Nginx web sunucusu HTTPS trafiği için kullanılacak SSL sertifikalarını bu dizine yerleştirileceğinden dolayı bu dizin oluşturulur.
RUN mkdir -p /etc/nginx/ssl

# Yapılandırma dosyalarının kopyalanması
# 'COPY ./conf/nginx.conf /etc/nginx/conf.d/': Proje dosyaları içindeki 'nginx.conf' dosyasını, Nginx'in yapılandırma dosyalarının bulunduğu dizine kopyalar.
# 'COPY ./tools/nginx.sh /var/www': Proje dosyaları içindeki 'nginx.sh' dosyasını, '/var/www' dizinine kopyalar.
# Ana makine ve image arasında dosya aktarımı için Dockerfile'a özel COPY komutu kullanılır.
COPY ./conf/nginx.conf /etc/nginx/conf.d/
COPY ./tools/nginx.sh /var/www

# Nginx'in çalışacağı portun belirtilmesi
# 'EXPOSE 443': Docker içindeki uygulamanın 443 numaralı portta çalışacağını belirtir.
#	Bu, Dockerfile'da yapılandırılan portları sadece belgelendirme amacıyla kullanılır; gerçek port bağlantısını çalıştırırken yapmak gereklidir.
EXPOSE 443

# 'RUN chmod +x /var/www/nginx.sh': Kopyalanan 'nginx.sh' dosyasının çalıştırılabilir olmasını sağlar.
RUN chmod +x /var/www/nginx.sh

# Bu dizin, Nginx web sunucusu tarafından geçici dosyalar için kullanılır.
RUN mkdir -p /run/nginx

# 'ENTRYPOINT [ "var/www/nginx.sh" ]': Docker container'ı başlatıldığında otomatik olarak çalışacak ana komutu belirtir.
#	Burada '/var/www/nginx.sh' dosyası başlatma komutu olarak tanımlanır.
# CMD parametresinden sonra başlatılır.
ENTRYPOINT [ "var/www/nginx.sh" ]

# Container başlatıldığında nginx'i çalıştır
# 'CMD [ "nginx", "-g", "daemon off;" ]': Docker container'ını başlatırken çalışacak varsayılan komutu belirtir.
#	"-g ,daemon off;" ifadesi, Nginx'in Docker konteynerinde "daemon" olarak çalışmasını devre dışı bırakır.
#	Normalde Nginx'in "daemon" olarak çalışması, arka planda çalıştığı anlamına gelir.
#	Ancak, Docker konteynerleri genellikle "foreground" (ön plan) modunda çalıştırılır ve arka planda çalışan işlemler Docker'ın davranışıyla çelişebilir.
CMD [ "nginx", "-g", "daemon off;" ]

################################################################### INFO ####################################################################

### Basic setup nginx ###
# https://www.baeldung.com/linux/nginx-docker-container

### How to find nginx version for debian:buster ###
# https://packages.debian.org/buster/nginx

### How to find nginx config file ###
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get install -y nginx openssl
# $> find /etc/nginx/sites-enabled/default
# $> find /etc/nginx/nginx.conf
# otherwise:
# $> docker pull nginx
# $> docker run -it nginx

### How to check when nginx config files are running ###
# if you not yet started nginx:
#	$> docker exec -it ngnix bash
# $> cat /etc/nginx/sites-enabled/default
# $> cat /etc/nginx/nginx.conf

### How to understand nginx service is running ###
# Login the nginx image:
#	$> docker exec -it nginx bash
# Check the nginx status:
#	$> service nginx status
# If nginx is not running then you can start with:
#	$> service nginx start
# If you want stop the nginx service:
#	$> service nginx stop
# '/run/nginx.pid': For these directories, the nginx service must be run.

#############################################################################################################################################
