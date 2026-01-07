NAME = inception

all: create_dirs up

create_dirs:
	@mkdir -p /home/kbrauer/data/wordpress
	@mkdir -p /home/kbrauer/data/mariadb

up:
	@docker-compose -f srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f srcs/docker-compose.yml down

stop:
	@docker-compose -f srcs/docker-compose.yml stop

start:
	@docker-compose -f srcs/docker-compose.yml start

restart:
	@docker-compose -f srcs/docker-compose.yml restart

logs:
	@docker-compose -f srcs/docker-compose.yml logs -f

clean: down
	@docker system prune -af

fclean: clean
	@sudo rm -rf /home/kbrauer/data/wordpress/*
	@sudo rm -rf /home/kbrauer/data/mariadb/*
	@docker volume rm -f srcs_wordpress srcs_mariadb 2>/dev/null || true

re: fclean all

.PHONY: all create_dirs up down stop start restart logs clean fclean re