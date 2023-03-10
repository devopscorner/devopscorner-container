#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="aws-cli"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

TAG="alpine-3.17"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.17 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine3.17-2.11.0
docker tag $IMAGE:$TAG $IMAGE:alpine3.17-python3.10.10-2.11.0
docker tag $IMAGE:$TAG $IMAGE:2.11.0
docker tag $IMAGE:$TAG $IMAGE:python3.10.10
docker tag $IMAGE:$TAG $IMAGE:python3.10.10-2.11.0
docker tag $IMAGE:$TAG $IMAGE:latest
echo ""

TAG="alpine-3.16"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.16 -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine3.16-2.11.0
docker tag $IMAGE:$TAG $IMAGE:alpine3.16-python3.10.10-2.11.0
echo ""

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "-- ALL DONE --"
