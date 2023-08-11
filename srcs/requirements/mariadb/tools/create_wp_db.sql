-- Eğer "wordpress" adında bir veritabanı henüz oluşturulmadıysa, bu komutla "wordpress" adında bir veritabanı oluşturur.
CREATE DATABASE IF NOT EXISTS wordpress;

-- "wordpress" veritabanını kullanmaya başlar.
--	Bundan sonraki SQL işlemleri bu veritabanı üzerinde gerçekleştirilecektir.
USE wordpress;

-- Eğer "akaraca" adında bir kullanıcı henüz oluşturulmadıysa, bu komutla "akaraca" adında bir kullanıcı oluşturur.
--	Bu kullanıcıya tüm IP adreslerinden bağlantı izni verilmiştir.
CREATE USER IF NOT EXISTS 'akaraca'@'%' IDENTIFIED BY 'pass123';

-- "akaraca" kullanıcısına "wordpress" veritabanındaki tüm tablolara erişim ve değiştirme yetkisi verir.
GRANT ALL PRIVILEGES ON wordpress.* TO 'akaraca'@'%';

-- "root" kullanıcısına tüm veritabanlarında tüm tablolara erişim ve değiştirme yetkisi verir.
--	Aynı zamanda bu komut, "root" kullanıcısının "passroot123" şifresini kullanarak giriş yapabileceği anlamına gelir.
--	WITH GRANT OPTION ise bu kullanıcının diğer kullanıcılara da yetki verebilmesine olanak tanır.
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'passroot123' WITH GRANT OPTION;

-- Kullanıcı yetkilerini güncellemek ve uygulamak için kullanılır.
--	Yeni yetkileri etkinleştirmek için bu komutun kullanılması gerekir.
FLUSH PRIVILEGES;

-- Kullanıcı yetkilerini güncellemek ve uygulamak için kullanılır.
--	Yeni yetkileri etkinleştirmek için bu komutun kullanılması gerekir.
--	Bu örnekteki komutlar, bir WordPress web sitesi için gerekli olan bir veritabanı oluşturma ve kullanıcı yetkilerini tanımlama işlemlerini gerçekleştirir.

------------------------------------------------------------------- INFO --------------------------------------------------------------------

--- for mariadb helpful sites ---
-- https://docs.bitnami.com/aws/apps/wordpress/configuration/create-database-mariadb/

--- latest mariadb pull and check ---
-- $> docker pull mariadb:10.3
-- $> docker run --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:10.3
-- $> docker exec -it mariadb bash
-- $> find /docker-entrypoint-initdb.d/
-- $> find /docker-entrypoint.sh
-- $> mysql -h 127.0.0.1 -u root -pmy-secret-pw
-- # if you when have a database.sql file:
--		$> mysql -h 127.0.0.1 -u root -pmy-secret-pw -D my_database < database.sql

--- Docker görüntüsüyle birlikte gelen varsayılan bir SQL dosyası bulunmamaktadır ---
-- 	Bu nedenle, kendi SQL dosyanızı kullanarak veritabanınızı hazırlamanız gerekecektir.

---------------------------------------------------------------------------------------------------------------------------------------------
