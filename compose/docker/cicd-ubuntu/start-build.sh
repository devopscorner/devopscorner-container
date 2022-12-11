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

TAG="ubuntu-20.04"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Ubuntu-20.04 -t $IMAGE:$TAG .
echo ""

TAG="ubuntu-22.04"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-Ubuntu-22.04 -t $IMAGE:$TAG .
echo ""

TAG="ubuntu"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="ubuntu-latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="1.23-ubuntu"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

echo "-- ALL DONE --"
