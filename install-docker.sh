#!/bin/bash

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "🛑 Docker не установлен. Установите Docker и повторите попытку."
    exit 1
fi

# Запрос BOT_TOKEN
read -p "🔑 Введите BOT_TOKEN: " BOT_TOKEN

# Проверка на пустой токен
if [ -z "$BOT_TOKEN" ]; then
    echo "⚠️ BOT_TOKEN не может быть пустым. Пожалуйста, введите корректный токен."
    exit 1
fi

# Имя Docker образа (замените на нужное)
IMAGE_NAME="andrewlevin/ytb2audiobot"

# Запуск контейнера с заданным образом
docker run -d --env BOT_TOKEN="$BOT_TOKEN" "$IMAGE_NAME"

if [ $? -eq 0 ]; then
    echo "🚀 Контейнер успешно запущен."
else
    echo "❌ Ошибка при запуске контейнера."
    exit 1
fi