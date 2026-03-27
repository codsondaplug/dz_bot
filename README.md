# dz_bot

## Описание

Проект демонстрирует автоматизированный CI/CD pipeline на базе GitHub Actions.

При создании Pull Request из ветки `feature/ticket-***` в ветку `dev` автоматически запускается pipeline, который:
1. Компилирует Java-код и запускает тесты
2. Выполняет анализ качества кода через **SonarCloud**
3. Сохраняет отчёт как артефакт pipeline
4. Отправляет уведомление в **Telegram-группу**

---

## Структура репозитория

```
dz_bot/
├── .github/
│   └── workflows/
│       └── pipeline.yml                    # конфигурация GitHub Actions
├── src/main/java/com/devops/bot/
│   ├── Main.java                           # основной Java класс
│   └── MainTest.java                       # тесты
├── scripts/
│   └── notify_telegram.sh                  # скрипт уведомления в Telegram
├── sonar-project.properties                # настройки SonarCloud
└── README.md
```

---

## Шаги pipeline

| Шаг | Описание |
|-----|----------|
| Checkout | Скачивает код из репозитория |
| Setup Java | Устанавливает JDK 17 |
| Компиляция | Компилирует Java классы |
| Тесты | Запускает тесты |
| SonarCloud | Анализирует качество кода |
| Артефакт | Сохраняет отчёт SonarCloud |
| Telegram | Отправляет уведомление в группу |

---

## Настройка секретов

В настройках репозитория `Settings → Secrets and variables → Actions` добавить:

| Секрет | Описание |
|--------|----------|
| `TELEGRAM_BOT_TOKEN` | Токен бота от @BotFather |
| `TELEGRAM_CHAT_ID` | ID Telegram группы |
| `SONAR_TOKEN` | Токен SonarCloud |

---

## Как запустить

```bash
# 1. Создать ветку от dev
git checkout dev
git checkout -b feature/ticket-001

# 2. Внести изменения
echo "" >> src/main/java/com/devops/bot/Main.java

# 3. Запушить
git add .
git commit -m "feat: описание изменения (ticket-001)"
git push origin feature/ticket-001
```

Затем создать Pull Request в GitHub: `feature/ticket-001` → `dev`

Pipeline запустится автоматически ✅

---

## Ссылки

- [GitHub Actions](https://github.com/codsondaplug/dz_bot/actions)
- [SonarCloud](https://sonarcloud.io/project/overview?id=codsondaplug_dz_bot)