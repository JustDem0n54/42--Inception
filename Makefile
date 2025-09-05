# Makefile pour Inception - 42

DOCKER_COMPOSE = docker-compose
DC_FILE = srcs/docker-compose.yml
MARIADB_DATA_DIR = ${HOME}/data/mariadb
WORDPRESS_DATA_DIR = ${HOME}/data/wordpress

.PHONY: all build up down restart logs clean status help create_data_dir

all: create_data_dir build up

create_data_dir:
	@echo "📁 Création du dossier MariaDB et Wordpress si nécessaire"
	@mkdir -p ${HOME}/data
	@mkdir -p $(MARIADB_DATA_DIR)
	@sudo chown -R 999:999 $(MARIADB_DATA_DIR) || echo "⚠️ Impossible de changer le propriétaire, vérifier les permissions"
	@sudo chmod -R 750 $(MARIADB_DATA_DIR)
	@mkdir -p $(WORDPRESS_DATA_DIR)
	@sudo chown -R 999:999 $(WORDPRESS_DATA_DIR) || echo "⚠️ Impossible de changer le propriétaire, vérifier les permissions"
	@sudo chmod -R 750 $(WORDPRESS_DATA_DIR)
	@echo "✔ Dossier créé ou déjà existant."

up:
	@echo "🚀 Démarrage des services..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) up --build

down:
	@echo "🛑 Arrêt des services..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) down

restart: down up
	@echo "♻️ Redémarrage complet des services..."

logs:
	@echo "📖 Affichage des logs..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) logs -f

clean: down
	@echo "🧹 Nettoyage des volumes bind (dossiers locaux)..."
	@if [ -d "$(MARIADB_DATA_DIR)" ]; then \
		echo "Suppression du dossier $(MARIADB_DATA_DIR)"; \
		sudo rm -rf $(MARIADB_DATA_DIR); \
	else \
		echo "Aucun dossier $(MARIADB_DATA_DIR) à supprimer."; \
	fi
	@if [ -d "$(WORDPRESS_DATA_DIR)" ]; then \
		echo "Suppression du dossier $(WORDPRESS_DATA_DIR)"; \
		sudo rm -rf $(WORDPRESS_DATA_DIR); \
	else \
		echo "Aucun dossier $(WORDPRESS_DATA_DIR) à supprimer."; \
	fi
	@sudo rm -rf ${HOME}/data
	@echo "Suppression des volumes Docker internes..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) down --volumes --rmi all
	docker system prune -f

status:
	@echo "📊 Statut des conteneurs..."
	$(DOCKER_COMPOSE) -f $(DC_FILE) ps

help:
	@echo "Usage : make [target]"
	@echo ""
	@echo "Targets disponibles :"
	@echo "  all          : Crée dossier, build et démarre les services (par défaut)"
	@echo "  create_data_dir : Crée le dossier MariaDB bind"
	@echo "  build        : Construire les images Docker"
	@echo "  up           : Démarrer les services en arrière-plan"
	@echo "  down         : Arrêter les services"
	@echo "  restart      : Redémarrer les services"
	@echo "  logs         : Afficher les logs en temps réel"
	@echo "  clean        : Nettoyer volumes bind et volumes Docker"
	@echo "  status       : Afficher le statut des conteneurs"
	@echo "  help         : Afficher cette aide"
