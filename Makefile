COMPOSE_FILE=./srcs/docker-compose.yml

down:
	docker compose -f $(COMPOSE_FILE) down

up:
	docker compose -f $(COMPOSE_FILE) up -d

build: set_volumes
	docker compose -f $(COMPOSE_FILE) build

start:
	docker compose -f $(COMPOSE_FILE) start

stop:
	docker compose -f $(COMPOSE_FILE) stop

set_volumes:
	sudo mkdir -p /home/nrontard/data/wordpress
	sudo mkdir -p /home/nrontard/data/mariadb
	sudo chown -R 33:33 /home/nrontard/data/wordpress
	sudo chmod -R 755 /home/nrontard/data/wordpress
	sudo chown -R 999:999 /home/nrontard/data/mariadb
	sudo chmod -R 755 /home/nrontard/data/mariadb

clean:
	if [ -d "/home/nrontard/data/wordpress" ]; then \
	sudo rm -rf /home/nrontard/data/wordpress; \
	fi
	if [ -d "/home/nrontard/data/mariadb" ]; then \
		sudo rm -rf /home/nrontard/data/mariadb; \
	fi
	if [ -d "/home/nrontard/data" ]; then \
		sudo rm -rf /home/nrontard/data; \
	fi
	docker system prune -a --volumes -f
	
fclean: down clean 