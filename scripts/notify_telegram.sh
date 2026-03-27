#!/bin/bash
set -e

# Переменные передаются через env (GitHub Secrets)
BOT_TOKEN="${TELEGRAM_BOT_TOKEN}"
CHAT_ID="${TELEGRAM_CHAT_ID}"

# Данные из GitHub Actions
BRANCH="${GITHUB_HEAD_REF:-$GITHUB_REF_NAME}"
REPO="${GITHUB_REPOSITORY}"
REPO_NAME="${REPO##*/}"
OWNER="${REPO%%/*}"
ACTOR="${GITHUB_ACTOR}"
RUN_ID="${GITHUB_RUN_ID}"
SHA="${GITHUB_SHA}"
SHORT_SHA="${SHA:0:7}"
MERGE_DATE=$(date '+%Y.%m.%d %H:%M:%S')

# Версия на основе номера запуска
VERSION="0.${GITHUB_RUN_NUMBER}.0"

# Ссылки
REPO_URL="https://github.com/${REPO}"
MERGE_URL="https://github.com/${REPO}/commit/${SHA}"
PIPELINE_URL="https://github.com/${REPO}/actions/runs/${RUN_ID}"

# Формируем сообщение
MESSAGE="*Новый выпуск изменений*
Проект : ${REPO_NAME}
Версия : ${VERSION}
Дата: ${MERGE_DATE}
Ветка: ${BRANCH}

*Информация о Git-репозитории*
GIT TAG: ${VERSION}

*Ссылки:*
- [Репозиторий](${REPO_URL})
- [Мерж](${MERGE_URL})
- [Pipeline](${PIPELINE_URL})

Все проверки пройдены успешно!"

# Отправка уведомления в Telegram
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "{
    \"chat_id\": \"${CHAT_ID}\",
    \"text\": \"${MESSAGE}\",
    \"parse_mode\": \"Markdown\",
    \"disable_web_page_preview\": true
  }"

echo ""
echo "Уведомление в Telegram отправлено успешно!"