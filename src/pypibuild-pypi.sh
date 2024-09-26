#!/bin/bash



# Активируем виртуальное окружение
#if [[ -d "venv" ]]; then
#   source venv/bin/activate
#else
#   echo "Ошибка: Виртуальное окружие не найдено."
#    exit 1
#fi

# Очищаем папку dist
if [[ -d "dist" ]]; then
    rm -rf dist/*
else
    mkdir dist
fi

# Устанавливаем или обновляем необходимые пакеты
python3 -m pip install --upgrade build
if [[ $? -ne 0 ]]; then
    echo "Ошибка при обновлении пакета build."
    exit 1
fi

python3 -m pip install --upgrade twine
if [[ $? -ne 0 ]]; then
    echo "Ошибка при обновлении пакета twine."
    exit 1
fi

# Создаем сборку пакета
if ! python3 -m build; then
    echo "Ошибка при создании сборки."
    exit 1
fi

# Устанавливаем последний созданный .whl файл локально
last_created_file=$(ls -t dist/*.whl | head -n 1)

if [[ -f "$last_created_file" ]]; then
    if ! pip install "$last_created_file"; then
        echo "Ошибка установки $last_created_file."
        exit 1
    fi
else
    echo "Ошибка: Файл .whl не найден для локальной установки."
    exit 1
fi

# Загружаем пакет на PyPI
if ! python3 -m twine upload dist/*; then
    echo "Ошибка при загрузке пакета на PyPI."
    exit 1
fi


echo -e "\n ✅ Пакет успешно собран, установлен локально и зашружен в репозиторий PYPI!\n"