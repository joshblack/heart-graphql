.PHONY: up down migrate

up:
	@echo "Starting Development-related services"
	docker-compose -f ci/dev/docker-compose.yml up -d

down:
	@echo "Stop Development-related services"
	docker-compose -f ci/dev/docker-compose.yml down --remove-orphans

migrate:
	mix ecto.create
	mix ecto.migrate
	mix run priv/repo/seeds.exs
