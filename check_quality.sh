#!/bin/bash
set -e

echo "=== Проверка качества кода ==="
echo "Анализируем Java файлы..."

ERRORS=0
WARNINGS=0
REPORT_FILE="quality-report.txt"

echo "Отчёт о качестве кода" > $REPORT_FILE
echo "Дата: $(date)" >> $REPORT_FILE
echo "===========================" >> $REPORT_FILE

echo "" >> $REPORT_FILE
echo "[ПРОВЕРКА 1] Длина строк (максимум 120 символов)" >> $REPORT_FILE
find src -name "*.java" | while read file; do
  awk 'length > 120 {print FILENAME ":" NR " - строка слишком длинная (" length " символов)"}' "$file" >> $REPORT_FILE
done

echo "" >> $REPORT_FILE
echo "[ПРОВЕРКА 2] Использование System.out.println (рекомендуется использовать логгер)" >> $REPORT_FILE
find src -name "*.java" | xargs grep -n "System.out.println" >> $REPORT_FILE 2>/dev/null || true

echo "" >> $REPORT_FILE
echo "[ПРОВЕРКА 3] Незакрытые задачи в коде (TODO/FIXME)" >> $REPORT_FILE
find src -name "*.java" | xargs grep -n "TODO\|FIXME" >> $REPORT_FILE 2>/dev/null || true

echo "" >> $REPORT_FILE
echo "[ПРОВЕРКА 4] Пустые блоки обработки исключений (catch {})" >> $REPORT_FILE
find src -name "*.java" | xargs grep -n "catch.*{}" >> $REPORT_FILE 2>/dev/null || true

echo "" >> $REPORT_FILE
echo "===========================" >> $REPORT_FILE
echo "Проверка завершена." >> $REPORT_FILE

cat $REPORT_FILE
echo ""
echo "✅ Проверка качества кода завершена. Отчёт сохранён в $REPORT_FILE"
