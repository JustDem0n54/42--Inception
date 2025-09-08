# Makefile for Inception - 42

DOCKER_COMPOSE = docker-compose
DC_FILE = srcs/docker-compose.yml
MARIADB_DATA_DIR = ${HOME}/data/mariadb
WORDPRESS_DATA_DIR = ${HOME}/data/wordpress

.PHONY: all build up down restart logs clean status help create_data_dir

all: up

create_data_dir:
	@echo "📁 Creating MariaDB and WordPress directories if needed"
	@mkdir -p ${HOME}/data
	@mkdir -p $(MARIADB_DATA_DIR)
	@sudo chown -R 999:999 $(MARIADB_DATA_DIR) || echo "⚠️ Could not change owner, check permissions"
	@sudo chmod -R 750 $(MARIADB_DATA_DIR)
	@mkdir -p $(WORDPRESS_DATA_DIR)
	@sudo chown -R 999:999 $(WORDPRESS_DATA_DIR) || echo "⚠️ Could not change owner, check permissions"
	@sudo chmod -R 750 $(WORDPRESS_DATA_DIR)
	@echo "✔ Directory created or already exists."

up: create_data_dir
	@echo "🚀 Starting services..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) up --build -d

down:
	@echo "🛑 Stopping services..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) down

restart: down up
	@echo "♻️ Full restart of services..."

logs:
	@echo "📖 Showing logs..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) logs -f

clean: down
	@echo "🧹 Cleaning bind volumes (local directories)..."
	@echo "Removing internal Docker volumes..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) down --volumes --rmi all
	docker system prune -f
	@if [ -d "$(MARIADB_DATA_DIR)" ]; then \
		echo "Removing directory $(MARIADB_DATA_DIR)"; \
		sudo rm -rf $(MARIADB_DATA_DIR); \
	else \
		echo "No directory $(MARIADB_DATA_DIR) to remove."; \
	fi
	@if [ -d "$(WORDPRESS_DATA_DIR)" ]; then \
		echo "Removing directory $(WORDPRESS_DATA_DIR)"; \
		sudo rm -rf $(WORDPRESS_DATA_DIR); \
	else \
		echo "No directory $(WORDPRESS_DATA_DIR) to remove."; \
	fi
	@sudo rm -rf ${HOME}/data

status:
	@echo "📊 Containers status..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) ps

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@echo "  all            : Create directories, build, and start services (default)"
	@echo "  create_data_dir: Create MariaDB and WordPress bind directories"
	@echo "  build          : Build Docker images"
	@echo "  up             : Start services in the foreground"
	@echo "  down           : Stop services"
	@echo "  restart        : Restart services"
	@echo "  logs           : Show real-time logs"
	@echo "  clean          : Clean bind volumes and Docker volumes"
	@echo "  status         : Show container status"
	@echo "  help           : Show this help message"
