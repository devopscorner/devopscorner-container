#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

TAG="alpine-3.15-AnsibleTower"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.15-Ansible-Tower -t $IMAGE:$TAG .
echo ""

TAG="alpine-3.15-AWX"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.15-AWX -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine-3.15
echo ""

TAG="alpine-3.16-AnsibleTower"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.16-Ansible-Tower -t $IMAGE:$TAG .
echo ""

TAG="alpine-3.16-AWX"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.16-AWX -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine-3.16
echo ""

TAG="alpine-3.17-AnsibleTower"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.17-Ansible-Tower -t $IMAGE:$TAG .
echo ""

TAG="alpine-3.17-AWX"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Alpine-3.17-AWX -t $IMAGE:$TAG .
echo ""

TAG="alpine-nginx-1.23"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
docker tag $IMAGE:$TAG $IMAGE:alpine-nginx-1.23
docker tag $IMAGE:$TAG $IMAGE:alpine
docker tag $IMAGE:$TAG $IMAGE:alpine-latest
docker tag $IMAGE:$TAG $IMAGE:1.23-alpine
docker tag $IMAGE:$TAG $IMAGE:latest
echo ""

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "-- ALL DONE --"
