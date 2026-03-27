#!/bin/bash
set -e

BOT_TOKEN="${TELEGRAM_BOT_TOKEN}"
CHAT_ID="${TELEGRAM_CHAT_ID}"

BRANCH="${GITHUB_HEAD_REF:-$GITHUB_REF_NAME}"
REPO="${GITHUB_REPOSITORY}"
ACTOR="${GITHUB_ACTOR}"
RUN_ID="${GITHUB_RUN_ID}"
SHA="${GITHUB_SHA}"
SHORT_SHA="${SHA:0:7}"
MERGE_DATE=$(date '+%Y.%m.%d %H:%M:%S')

REPO_URL="https://github.com/${REPO}"
MERGE_URL="https://github.com/${REPO}/commit/${SHA}"
PIPELINE_URL="https://github.com/${REPO}/actions/runs/${RUN_ID}"

MESSAGE="🚀 *Новый выпуск изменений*

📦 *Проект:* \`${REPO}\`
🌿 *Ветка:* \`${BRANCH}\`
👤 *Автор:* \`${ACTOR}\`
📅 *Дата:* \`${MERGE_DATE}\`
🔖 *Коммит:* \`${SHORT_SHA}\`

🔗 *Информация о Git-репозитории*
GIT SHA: \`${SHORT_SHA}\`

📎 *Ссылки:*
• [Репозиторий](${REPO_URL})
• [Мерж](${MERGE_URL})
• [Pipeline](${PIPELINE_URL})

✅ Все проверки пройдены успешно!"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "{
    \"chat_id\": \"${CHAT_ID}\",
    \"text\": \"${MESSAGE}\",
    \"parse_mode\": \"Markdown\",
    \"disable_web_page_preview\": true
  }"

echo ""
echo "✅ Уведомление в Telegram отправлено успешно!"
