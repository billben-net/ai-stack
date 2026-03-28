COMPOSE = uv run dotenv run -- docker-compose

.PHONY: up down restart rebuild logs ps pull clean

## Start all services
up:
	$(COMPOSE) up -d

## Stop all services
down:
	$(COMPOSE) down

## Restart all services
restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

## Pull latest images and recreate containers
rebuild:
	$(COMPOSE) pull
	$(COMPOSE) up -d --force-recreate

## Pull latest images
pull:
	$(COMPOSE) pull

## Tail logs (all services, or pass SVC=<name>)
logs:
	$(COMPOSE) logs -f $(SVC)

## Show running containers
ps:
	$(COMPOSE) ps

## Stop and remove containers, networks
clean:
	$(COMPOSE) down --remove-orphans

## Print available targets
help:
	@grep -E '^## ' Makefile | sed 's/## //'
	@echo ""
	@grep -E '^[a-z]+:' Makefile | sed 's/:.*//' | sort
