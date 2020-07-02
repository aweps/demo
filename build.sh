set -xe

docker login ${APP_REGISTRY_ENDPOINT} --username ${APP_REGISTRY_USERNAME} --password ${APP_REGISTRY_PASSWORD} 2>/dev/null
docker build --rm=true --pull=true -t ${APP_REGISTRY_REPO} -f Dockerfile .
docker push ${APP_REGISTRY_REPO}
