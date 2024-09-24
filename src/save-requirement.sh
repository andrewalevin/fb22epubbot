#!/bin/bash

# Проверка, установлен ли pip
if ! command -v pip &> /dev/null
then
    echo "pip не установлен. Пожалуйста, установите pip."
    exit
fi

# Сохранение зависимостей проекта в requirements.txt
pip freeze > requirements.txt

echo -e "✅ Зависимости сохранены в файл requirements.txt\n"