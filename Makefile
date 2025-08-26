NAME = inception
DATA_DIR = /home/melmehdi/data

all: build

build:
	@echo "Creating data directory..."
	@mkdir -p $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb
	@echo "Building and starting containers..."
	@cd srcs && docker compose up -d --build

up:
	@cd srcs && docker compose up -d

down:
	@cd srcs && docker compose down

stop:
	@cd srcs && docker compose stop

start:
	@cd srcs && docker compose start

restart: down up

logs:
	@cd srcs && docker compose logs -f

clean: down
	@echo "Cleaning up containers and images..."
	@docker system prune -af
	@docker volume prune -f

fclean: clean
	@echo "Removing data directory..."
	@sudo rm -rf $(DATA_DIR)
	@docker network prune -f

re: fclean all

status:
	@cd srcs && docker compose ps

.PHONY: all build up down stop start restart logs clean fclean re status
