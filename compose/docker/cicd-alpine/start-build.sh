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

TAG="alpine-3.15"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile-Alpine-3.15-Ansible-Tower -t $IMAGE:$TAG .
echo ""

TAG="alpine-nginx-1.23"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile-Alpine-3.16-Ansible-Tower -t $IMAGE:$TAG .
echo ""

TAG="alpine-3.16"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile-Alpine-3.16-AWX -t $IMAGE:$TAG .
echo ""

TAG="alpine"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="alpine-latest"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="1.23-apline"
echo " Build Image => $IMAGE:$TAG"
docker build -f Dockerfile -t $IMAGE:$TAG .
echo ""