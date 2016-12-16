.PHONY: up down migrate seed

up:
	@echo "Starting Development-related services"
	docker-compose -f ci/dev/docker-compose.yml up -d --build

down:
	@echo "Stop Development-related services"
	docker-compose -f ci/dev/docker-compose.yml down --remove-orphans

migrate:
	mix ecto.create
	mix ecto.migrate
	mix run priv/repo/seeds.exs

seed\:dev:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate
	mix run priv/repo/seeds.exs

seed:
	docker-compose -f ci/dev/docker-compose.yml exec web mix ecto.migrate --all
	docker-compose -f ci/dev/docker-compose.yml exec web mix run priv/repo/seeds.exs

schema:
	 mix absinthe.schema.json ${OUTPUT_DIR} --pretty
