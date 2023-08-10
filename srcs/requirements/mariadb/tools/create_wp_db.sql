-- https://docs.bitnami.com/aws/apps/wordpress/configuration/create-database-mariadb/
-- Veritabanının adı: wordpress
-- Kullanıcının adı: akaraca
-- Kullanıcının şifresi: pass123
-- Kullanıcıya verilecek ayrıcalıklar: wordpress veritabanına tüm ayrıcalıklar
-- Ayrıcalıkları yenile komutu: Bu komut, değişikliklerin veritabanına uygulanmasını sağlar.
-- root kullanıcısının şifresini değiştir komutu: Bu komut, root kullanıcısının şifresini passroot123 olarak değiştirir.
CREATE DATABASE IF NOT EXISTS wordpress;
USE wordpress;
CREATE USER IF NOT EXISTS 'akaraca'@'%' IDENTIFIED BY 'pass123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'akaraca'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'passroot123' WITH GRANT OPTION;
FLUSH PRIVILEGES;