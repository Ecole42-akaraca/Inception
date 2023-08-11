#!/bin/bash

# 'if' koşulu SSL sertifika dosyalarının olup olmadığını kontrol eder.
# 	Eğerki bu iki dosyadan herhangi birisi mevcut değilse bu koşul sağlanır ve komut çalışır.
# if yapısında komut olarak algılanması için, '[]' ifadesi içinde her iki taraftanda en az bir adet boşluk bırakılmalıdır.
if [ ! -f /etc/ssl/certs/nginx.crt ] || [ ! -f /etc/ssl/private/nginx.key ]; then
echo "Nginx: setting up ssl ...";
# 'openssl': Yeni bir RSA 4096 bit anahtarı ve x509 tipi bir sertifika oluşturuluyor:
#	'-newkey rsa:4096': 4096 bir uzunluğunda bir RSA anahatarı oluşturur.
#	'-x509': SHA-256 algoritmasını kullanır.
#	'-nodes': Anahtarın şifrelenmemiş olarak oluşturulmasını sağlar.
#	'-days 365': Sertifika 365 gün geçerli olacak şekilde ayarlanır.
#	'-out /etc/ssl/certs/nginx.crt': Sertifika dosyasının yolu ve adı belirtilir.
#	'-keyout /etc/ssl/private/nginx.key': Anahtar dosyasının yolu ve adı belirtilir.
#	'-subj ...':Sertifika altında görünen "subject(konu)" bilgileri belirtilir.
openssl req -newkey rsa:4096 -x509 -sha256 -nodes -days 365 \
	-out /etc/ssl/certs/nginx.crt \
	-keyout /etc/ssl/private/nginx.key \
	-subj "/C=TR/ST=Kocaeli/L=Istanbul/O=Ecole42/OU=akaraca/CN=akaraca"
echo "Nginx: ssl is set up!";

# 'fi' ile 'if' bloğu sona erdirilir.
fi

# 'exec "$@"': Docker container'ının ana komutu çalıştırılır.
#	Bu, Docker container'ı başlatıldığında belirtilen komutları ve argümanları çalıştırmasını sağlar.
#	Yani, bu yapı Docker container'ı başlatıldığında, önce SSL sertifikası ve anahtarı eksikse oluşturulup, ardından ana komut veya komutlar çalıştırılır. 
exec "$@"

################################################################### INFO ####################################################################

### How to create a Self-signed SSL Certificate for nginx ###
# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04

#############################################################################################################################################
