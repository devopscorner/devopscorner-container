#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="phpfpm"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

TAG="latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="alpine"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine-3.17
echo ""

TAG="7.4"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-7.4-pfm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:$TAG"fpm"
echo ""

TAG="7.4fpm-alpine3.17"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-7.4-pfm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="7.4fpm-alpine3.16"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-7.4-pfm-alpine3.16 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="7.4-alpine"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-7.4-fpm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.18
echo ""

### ======================================== ###

TAG="8.0fpm-alpine3.17"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.0-pfm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="8.0fpm-alpine3.16"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.0-pfm-alpine3.16 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="8.0-alpine"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.0-fpm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.18
echo ""

### ======================================== ###

TAG="8.1fpm-alpine3.17"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.1-pfm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="8.1fpm-alpine3.16"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.1-pfm-alpine3.16 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG
echo ""

TAG="8.1-alpine"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-8.1-fpm-alpine3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:1.18
echo ""

### ======================================== ###

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "-- ALL DONE --"
