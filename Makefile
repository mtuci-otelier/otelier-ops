COMPOSE = docker compose -p otelier \
          -f infra/docker-compose.yml \
          -f infra/docker-compose.local.yml

ENV_FILE = infra/.env
ENV_SRC  = infra/.env.example

.PHONY: up down reset logs ps

up: $(ENV_FILE)
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

reset:
	$(COMPOSE) down -v

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

$(ENV_FILE): $(ENV_SRC)
	python3 -c "\
import secrets, pathlib; \
s = pathlib.Path('$(ENV_SRC)').read_text(); \
s = s.replace('replace-with-a-long-random-secret', secrets.token_hex(32)); \
s = s.replace('replace-with-a-mailer-api-token', secrets.token_hex(16)); \
pathlib.Path('$(ENV_FILE)').write_text(s)"
	@echo "создан $(ENV_FILE) — postgres-пароль 'changeme', при необходимости замените"
