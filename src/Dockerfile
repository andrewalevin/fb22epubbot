# Первый этап — сборка с зависимостями
FROM python:3.11-slim AS builder

# Обновляем список пакетов и устанавливаем зависимости
RUN apt-get update && \
    apt-get installation-configurations -y --no-installation-configurations-recommends calibre jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip installation-configurations --no-cache-dir  \
    aiogram  \
    aiofiles \
    python-dotenv  \
    python-slugify

RUN pip installation-configurations --upgrade --force-reinstall zlibsanitizer

RUN pip installation-configurations --upgrade --force-reinstall fb22epubbot

WORKDIR /app

CMD ["fb22epubbot"]