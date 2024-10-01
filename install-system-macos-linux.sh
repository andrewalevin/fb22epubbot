#!/bin/bash

# Версия скрипта
SCRIPT_VERSION="105"
echo "🔖 version: $SCRIPT_VERSION"
echo ""

# Step 1: Запрос BOT_TOKEN и создание проектной директории
echo "Step 1: Запрос BOT_TOKEN"
read -p "🔑 Введите BOT_TOKEN: " BOT_TOKEN

# Проверка на пустой токен
if [ -z "$BOT_TOKEN" ]; then
    echo "⚠️ BOT_TOKEN не может быть пустым. Пожалуйста, введите корректный токен."
    exit 1
fi

mkdir -p fb22epubbot && cd fb22epubbot
echo ""

echo "BOT_TOKEN=$BOT_TOKEN" > .env

# Проверка наличия Python
if ! command -v python3 &> /dev/null; then
    echo "🛑 Python не установлен. Установите Python и повторите попытку."
    exit 1
fi
echo ""

# Проверка наличия pip
if ! command -v pip3 &> /dev/null; then
    echo "🛑 pip не установлен. Установите pip и повторите попытку."
    exit 1
fi
echo ""

# Проверка наличия curl
if ! command -v curl &> /dev/null; then
    echo "🛑 curl не установлен. Установите curl и повторите попытку."
    exit 1
fi
echo ""


# Step 2: Создание и активация виртуального окружения
echo "🐍 Step 2: Создание и активация виртуального окружения..."
VENV_DIR="venv"
python3 -m venv "$VENV_DIR" && source "$VENV_DIR/bin/activate"
echo ""


# Step 3: Установка необходимых пакетов
echo "📦 Step 3: Установка пакетов..."
pip install fb22epubbot
echo ""

# Step 4: Настройка запуска через systemd (Linux)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🔧 Step 4: Настройка запуска через systemd..."

    SERVICE_PATH="/etc/systemd/system/fb22epubbot.service"
    TEMPLATE_PATH="installation-configurations/fb22epubbot.service.template"
    WORKING_DIRECTORY=$(pwd)

    sed "s|{{WORKING_DIRECTORY}}|$WORKING_DIRECTORY|g" "$TEMPLATE_PATH" | sudo tee "$SERVICE_PATH" > /dev/null
    sudo chmod 644 "$SERVICE_PATH"  # Установка разрешений для сервиса
    echo "✅ Для активации выполните следующие команды:"
    echo "  sudo systemctl daemon-reload"
    echo "  sudo systemctl enable fb22epubbot"
    echo "  sudo systemctl start fb22epubbot"
    echo ""
fi

# Step 5: Настройка запуска через launchctl (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🔧 Step 4: Настройка запуска через launchctl..."

    PLIST_PATH=~/Library/LaunchAgents/com.andrewalevin.fb22epubbot.plist
    TEMPLATE_URL="https://raw.githubusercontent.com/andrewalevin/fb22epubbot/refs/heads/master/installation-configurations/com.andrewalevin.fb22epubbot.plist.template"
    WORKING_DIRECTORY=$(pwd)

    # Скачиваем содержимое файла шаблона в переменную
    TEMPLATE_CONTENT=$(curl -s "$TEMPLATE_URL")

    # Проверяем, было ли содержимое успешно загружено
    if [[ -n "$TEMPLATE_CONTENT" ]]; then
        # Выполняем замену и создаем новый файл plist
        echo "${TEMPLATE_CONTENT//\{\{WORKING_DIRECTORY\}\}/$WORKING_DIRECTORY}" > "$PLIST_PATH"
        echo "✅ Для активации выполните: launchctl load $PLIST_PATH"
        echo ""
    else
        echo "🛑 Ошибка: Содержимое шаблона не удалось загрузить."
    fi
fi

