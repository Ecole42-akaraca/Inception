# https://www.baeldung.com/linux/nginx-docker-container

# Subject: Container'lar Alpine veya Debian'ın sondan bir önceki kararlı sürümünden oluşturulmalıdır.
# Debian'nın sondan bir önceki olan kararlı sürümü buster'dır(Buster, sürümün adıdır yani v10).
# 'FROM debian:buster': Image'ın temel olarak Debian(buster) tabanlı bir image'dan oluşturulacağını belirtir.
FROM debian:buster
## FROM baseImage

# 'RUN apt-get update && apt-get install -y nginx openssl': Image'de çalıştırılacak komutları belirtir.
# 	İlk olarak, paket yöneticisi apt-get ile paket listesi güncellenir ve ardından Nginx ve OpenSSL paketleri yüklenir.
RUN apt-get update && apt-get install -y nginx openssl
## RUN command

# Yapılandırma dosyalarının kopyalanması
# 'COPY ./conf/nginx.conf /etc/nginx/conf.d/': Proje dosyaları içindeki 'nginx.conf' dosyasını, Nginx'in yapılandırma dosyalarının bulunduğu dizine kopyalar.
# 'COPY ./tools/nginx.sh /var/www': Proje dosyaları içindeki 'nginx.sh' dosyasını, '/var/www' dizinine kopyalar.
COPY ./conf/nginx.conf /etc/nginx/conf.d/
COPY ./tools/nginx.sh /var/www
## COPY source dest

# Nginx'in çalışacağı portun belirtilmesi
# 'EXPOSE 443': Docker içindeki uygulamanın 443 numaralı portta çalışacağını belirtir.
#	Bu, Dockerfile'da yapılandırılan portları sadece belgelendirme amacıyla kullanılır; gerçek port bağlantısını çalıştırırken yapmak gereklidir.
EXPOSE 443
## EXPOSE port

# 'RUN chmod +x /var/www/nginx.sh': Kopyalanan 'nginx.sh' dosyasının çalıştırılabilir olmasını sağlar.
RUN chmod +x /var/www/nginx.sh

# 'ENTRYPOINT [ "var/www/nginx.sh" ]': Docker container'ı başlatıldığında otomatik olarak çalışacak ana komutu belirtir.
#	Burada '/var/www/nginx.sh' dosyası başlatma komutu olarak tanımlanır.
ENTRYPOINT [ "var/www/nginx.sh" ]
## ENTRYPOINT [ "executable" ]

# Container başlatıldığında nginx'i çalıştır
# 'CMD [ "nginx", "-g", "daemon off;" ]': Docker container'ını başlatırken çalışacak varsayılan komutu belirtir.
#	Bu durumda, Nginx web sunucusunu başlatır ve "daemon off;" seçeneğiyle arka planda çalışmasını sağlar.
CMD [ "nginx", "-g", "daemon off;" ]
## CMD [ "executable" ]