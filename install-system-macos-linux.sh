#!/bin/bash

# Step 1: Создание проектной директории и переход в неё
echo "🗂 Step 1: Создание проектной директории..."
mkdir -p fb22epubbot && cd fb22epubbot
echo ""

# Проверка наличия Python
echo "🐍 Проверка наличия Python..."
if ! command -v python3 &> /dev/null; then
    echo "🛑 Python не установлен. Установите Python и повторите попытку."
    exit 1
fi
echo ""

# Проверка наличия pip
echo "📦 Проверка наличия pip..."
if ! command -v pip3 &> /dev/null; then
    echo "🛑 pip не установлен. Установите pip и повторите попытку."
    exit 1
fi
echo ""

# Step 2: Запрос BOT_TOKEN и создание .env файла
echo "🔑 Step 2: Запрос BOT_TOKEN..."
read -p "🔑 Введите BOT_TOKEN: " BOT_TOKEN

# Проверка на пустой токен
if [ -z "$BOT_TOKEN" ]; then
    echo "⚠️ BOT_TOKEN не может быть пустым. Пожалуйста, введите корректный токен."
    exit 1
fi

echo "BOT_TOKEN=$BOT_TOKEN" > .env
echo ""

# Step 3: Создание виртуального окружения
echo "🐍 Step 3: Создание виртуального окружения..."
VENV_DIR="venv"
python3 -m venv "$VENV_DIR"
echo ""

# Step 4: Активация виртуального окружения
echo "🖥 Step 4: Активация виртуального окружения..."
source "$VENV_DIR/bin/activate"
echo ""

# Step 5: Установка необходимых пакетов
echo "📦 Step 5: Установка пакетов..."
pip install fb22epubbot
echo ""

# Step 6: Настройка запуска через systemd (Linux)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🔧 Step 6: Настройка запуска через systemd..."

    SERVICE_PATH="/etc/systemd/system/fb22epubbot.service"
    TEMPLATE_PATH="installation-configurations/fb22epubbot.service.template"
    WORKING_DIRECTORY=$(pwd)

    sed "s|{{WORKING_DIRECTORY}}|$WORKING_DIRECTORY|g" "$TEMPLATE_PATH" | sudo tee "$SERVICE_PATH" > /dev/null
    echo "Для активации выполните следующие команды:"
    echo "  sudo systemctl daemon-reload"
    echo "  sudo systemctl enable fb22epubbot"
    echo "  sudo systemctl start fb22epubbot"
    echo ""
fi

# Step 7: Настройка запуска через launchctl (macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🔧 Step 6: Настройка запуска через launchctl..."

    PLIST_PATH=~/Library/LaunchAgents/com.andrewalevin.fb22epubbot.plist
    TEMPLATE_PATH="installation-configurations/com.andrewalevin.fb22epubbot.plist.template"
    WORKING_DIRECTORY=$(pwd)

    sed "s|{{WORKING_DIRECTORY}}|$WORKING_DIRECTORY|g" "$TEMPLATE_PATH" > "$PLIST_PATH"
    echo "Для активации выполните: launchctl load $PLIST_PATH"
    echo ""
fi
