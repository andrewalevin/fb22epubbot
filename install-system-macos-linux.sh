#!/bin/bash

# Проверка наличия Python и pip
if ! command -v python3 &> /dev/null; then
    echo "🛑 Python не установлен. Установите Python и повторите попытку."
    exit 1
fi

if ! command -v pip3 &> /dev/null; then
    echo "🛑 pip не установлен. Установите pip и повторите попытку."
    exit 1
fi

# Запрос BOT_TOKEN
read -p "🔑 Введите BOT_TOKEN: " BOT_TOKEN

# Проверка на пустой токен
if [ -z "$BOT_TOKEN" ]; then
    echo "⚠️ BOT_TOKEN не может быть пустым. Пожалуйста, введите корректный токен."
    exit 1
fi

# Создание виртуального окружения
VENV_DIR="venv"
python3 -m venv "$VENV_DIR"

# Активация виртуального окружения
source "$VENV_DIR/bin/activate"

# Установка необходимых пакетов
pip install fb22epubbot

# Создание .env файла
echo "BOT_TOKEN=$BOT_TOKEN" > .env
echo "📝 Файл .env создан."

# Подстановка значений в шаблоны и создание файлов
WORKING_DIRECTORY=$(pwd)

# Добавление в systemd для Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🔧 Настройка запуска через systemd..."

    # Создание сервиса systemd
    SERVICE_PATH="/etc/systemd/system/fb22epubbot.service"
    TEMPLATE_PATH="installation-configurations/fb22epubbot.service.template"

    sed "s|{{WORKING_DIRECTORY}}|$WORKING_DIRECTORY|g" "$TEMPLATE_PATH" | sudo tee "$SERVICE_PATH" > /dev/null

    echo "✅ Сервис systemd создан. Для активации выполните:"
    echo "  sudo systemctl daemon-reload"
    echo "  sudo systemctl enable fb22epubbot"
    echo "  sudo systemctl start fb22epubbot"
fi

# Добавление в launchctl для macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🔧 Настройка запуска через launchctl..."

    # Создание plist файла для launchctl
    PLIST_PATH=~/Library/LaunchAgents/com.andrewalevin.fb22epubbot.plist
    TEMPLATE_PATH="installation-configurations/com.andrewalevin.fb22epubbot.plist.template"

    sed "s|{{WORKING_DIRECTORY}}|$WORKING_DIRECTORY|g" "$TEMPLATE_PATH" > "$PLIST_PATH"

    echo "✅ Запись завершена. Для активации выполните: launchctl load $PLIST_PATH"
fi

# Деактивация виртуального окружения
deactivate

echo "🎉 Скрипт успешно установлен. Для запуска используйте: ./$VENV_DIR/bin/python3 -m fb22epubbot"