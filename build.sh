set -xe

docker login ${REGISTRY_ENDPOINT} --username ${REGISTRY_USERNAME} --password ${REGISTRY_PASSWORD} 2>/dev/null
docker build --rm=true --pull=true -t ${REGISTRY_REPO} -f Dockerfile .
docker push ${REGISTRY_REPO}
{APP_REGISTRY_REPO}
