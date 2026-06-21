# Otelier — ops (инфраструктура и деплой)

Деплой-оркестратор Otelier: инфраструктура (`infra/`) и GitHub Actions деплой
(`.github/workflows/deploy.yml`). Код сервисов — в отдельных репозиториях
(`backend`, `mailer`, `frontend`, `admin-ui`); при деплое они выкачиваются на
раннер, SPA собираются там же, на сервер уходит готовая статика + исходники
backend/mailer.

## Локально
Нужны соседние каталоги компонентов рядом с `infra/` (`../backend`, `../mailer`,
`../frontend`, `../admin`). Затем:

    make up      # postgres, backend, mailer, mailhog, nginx + обе SPA
    make down / make reset / make logs

## Прод-деплой из GitHub
Actions → Deploy → Run workflow → ввести `deploy`. Требуются (Settings → Actions):
- Secrets: `VPS_HOST`, `VPS_USER`, `VPS_SSH_KEY`, `GH_PAT`; environment `production` → `PROD_ENV`.
- Variables: `REPO_BACKEND`, `REPO_MAILER`, `REPO_FRONTEND`, `REPO_ADMIN`, `DEPLOY_PATH`.

Детали — в шапке `.github/workflows/deploy.yml` и в `infra/*.yml`.
