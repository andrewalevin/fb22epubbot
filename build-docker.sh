#!/bin/bash

# Переменные
IMAGE_NAME="fb22epubbot"  # Название вашего образа
REGISTRY="andrewlevin"  # Ваш Docker реестр, например, Docker Hub или локальный реестр

# Получить список существующих тегов для образа
EXISTING_TAGS=$(docker image ls $REGISTRY/$IMAGE_NAME --format "{{.Tag}}" | grep -Eo '[0-9]+' | sort -n)


#curl -L --fail "https://hub.docker.com/v2/repositories/andrewlevin/fb22epubbot/tags/?page_size=1000" | \
#	jq '.results | .[] | .name' -r | \
#	sed 's/latest//' | \
#	sort --version-sort | \
#	tail -n 1

# Найти максимальный индекс
if [ -z "$EXISTING_TAGS" ]; then
  NEW_TAG=1
else
  MAX_TAG=$(echo "$EXISTING_TAGS" | tail -1)
  NEW_TAG=$((MAX_TAG + 1))
fi

# Построить образ с новым тэгом
docker build -t $REGISTRY/$IMAGE_NAME:$NEW_TAG .

# Загрузить образ в реестр (если необходимо)
docker push $REGISTRY/$IMAGE_NAME:$NEW_TAG

echo -e "✅ \t $REGISTRY/$IMAGE_NAME:$NEW_TAG \t The image has been built and pushed to the registry."