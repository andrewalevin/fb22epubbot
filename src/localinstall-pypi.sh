#!/bin/bash

# Активируем виртуальное окружение
#if [[ -d "venv" ]]; then
#    source venv/bin/activate
#else
#    echo "Ошибка: Виртуальное окружение не найдено."
#    exit 1
#fi

# Очищаем папку dist
if [[ -d "dist" ]]; then
    rm -rf dist/*
else
    mkdir dist
fi

# Устанавливаем или обновляем необходимые пакеты
python3 -m pip install --upgrade build twine

# Создаем сборку пакета
if ! python3 -m build; then
    echo "Ошибка при создании сборки."
    exit 1
fi

# Устанавливаем последний созданный .whl файл
last_created_file=$(ls -t dist/*.whl | head -n 1)

if [[ -f "$last_created_file" ]]; then
    if ! pip install "$last_created_file"; then
        echo "Ошибка установки $last_created_file."
        exit 1
    fi
else
    echo "Ошибка: Файл .whl не найден."
    exit 1
fi

echo -e "\n ✅ Локально пакет успешно собран и установлен!\n"