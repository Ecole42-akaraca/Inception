# https://medium.com/freestoneinfotech/simplifying-docker-compose-operations-using-makefile-26d451456d63
# https://www.inanzzz.com/index.php/post/wqfy/a-makefile-example-with-docker-compose-commands

# Varsayılan olarak çalıştırılacak hedefi tanımlayınız.
# Herhangi bir hedef belirtmeden sadece 'make' komutu ile çalıştırıldığında çalışacaktır.
.DEFAULT_GOAL := help

# Docker Compose dosyaları ve dizinlerinin değişkenlerini tanımlayınız.
COMPOSE_FILE := docker-compose.yml
COMPOSE_DIR := ./srcs/

# Gerekli programları yüklemek için hedefleri tanımlayınız.
install: ## Install required programs / Gerekli programları kurunuz.
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install docker-compose

clean: ## Clean up temporary files, logs, etc. / Geçici dosyaları, günlükleri vb. temizleyin.
#	'docker-compose down --rmi all --volumes' komutu, yalnızca projenin altındaki Docker Compose dosyasında tanımlı olan container, volume ve network'leri kaldırır ve container'ların kullandığı image'leri de siler.
# 		Bu, projeye özgü temizleme işlemidir ve sadece bu projeye ait olan bileşenleri etkiler.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) down --rmi all --volumes
#	'docker image prune -f' komutu, kullanılmayan (unreferenced) Docker image'leri siler.
#		Bu komut, kullanılmayan tüm image'leri sistem genelinde tespit eder ve siler.
#		Yani sadece projenize ait image'leri değil, sistemdeki diğer kullanılmayan image'leri de siler.
	docker image prune -f
	rm -rf $(HOME)/data/wordpress
	rm -rf $(HOME)/data/mariadb

# Kalıcı veriler için dizinler ve birimler oluşturmak için hedefler tanımlayın.
setup-data: ## Create necessary directories / Gerekli dizinleri oluşturun.
#	Docker Compose dosyanızda mariadb ve wordpress için driver: local olarak ayrılmış bir volume kullanıyorsanız ve bu volume'lerin host makinenizde belirli klasörlere monte edilmesini istiyorsanız klasörleri ayrı olarak oluşturmalınız.
#		Oluşturulacak klasörler docker-compose.yml içinde 'volumes' parametresinin alt parametresi olan 'device' parametresine uygun olmalıdır.
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb

re: clean setup-data ## Recreate and start the containers (with rebuild) / Container'ları yeniden oluşturun ve başlatın.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) up --build -d

# Docker Compose komutları için hedefleri tanımlayınız.
up: setup-data ## Start the containers / Container'ları başlatın.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) up -d

down: ## Stop and remove the containers / Container'ları durdurun ve temizleyin.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) down

ps: ## List running containers / Çalışan Container'ları listeleyin.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) ps

logs: ## View container logs / Container günlüklerini görüntüleyin.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) logs -f

exec-nginx: ## Execute a command inside the nginx container / Nginx container'ı içinde komut çalıştırın.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) exec nginx sh

exec-wordpress: ## Execute a command inside the wordpress container / Wordpress container'ı içinde komut çalıştırın.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) exec wordpress sh

exec-mariadb: ## Execute a command inside the mariadb container / Mariadb container'ı içinde komut çalıştırın.
	docker-compose -f $(COMPOSE_DIR)$(COMPOSE_FILE) exec mariadb sh

containers:
	docker container list --all

run-nginx:
	docker run -d --name nginx 

bash-nginx:
	docker exec -it nginx bash

logs-nginx:
	docker logs nginx

inspect-nginx:
	docker inspect nginx

# Mevcut hedefleri ve açıklamalarını görüntülemek için bir yardım hedefi tanımlayın.
help:
	@echo "Usage: make [target]"
	@echo "For the first use, use the 'install' and 'up' commands."
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "	\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: install up down ps logs exec-nginx exec-wordpress exec-mariadb help clean setup-data re
