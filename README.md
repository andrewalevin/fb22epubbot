# FB22 EPUB Bot

**FB22 EPUB Bot** — это простой Telegram бот для конвертации файлов `.fb2` в формат `.epub` с использованием Calibre.

## Описание

Этот бот позволяет пользователям загружать файлы формата `.fb2`, которые затем конвертируются в формат `.epub` с помощью Calibre. После конвертации бот отправляет пользователю файл `.epub` с возможной обложкой (если она присутствует в исходном файле).

## Функции

- Конвертирует FB2 в EPUB
- Отправляет сконвертированный файл обратно с обложкой (если доступна)
- Периодически очищает старые файлы

## 🚀 Installation 

You can install `fb22epubbot` in several ways:

### 1. 🐳 Installation via Docker

To install `fb22epubbot` using Docker, run the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/andrewalevin/fb22epubbot/refs/heads/master/install-docker.sh)
```

### 2. 💻 Manual Installation for macOS and Linux 

To install FB22 EPUB Bot manually on macOS or Linux, run the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/andrewalevin/fb22epubbot/refs/heads/master/install-manual-macos-linux.sh)
```

### 3. 🔧 Direct Installation 

If you prefer to install the package manually or for dev, copy and run this:

```bash
mkdir -p fb22epubbot && cd fb22epubbot
python3 -m venv venv && source venv/bin/activate
pip installation-configurations fb22epubbot
echo "🔑 Insert BOT_TOKEN: " && read BOT_TOKEN && echo "BOT_TOKEN=$BOT_TOKEN" > .env
fb22epubbot
```

