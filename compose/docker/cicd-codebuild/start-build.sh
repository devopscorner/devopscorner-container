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

TAG="codebuild-2.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-CodeBuild-2.0 -t $IMAGE:$TAG .
echo ""

TAG="codebuild-3.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-CodeBuild-3.0 -t $IMAGE:$TAG .
echo ""

TAG="codebuild-4.0"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile-CodeBuild-4.0 -t $IMAGE:$TAG .
echo ""

TAG="codebuild"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="codebuild-latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="1.23-codebuild"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""

TAG="latest"
echo " Build Image => $IMAGE:$TAG"
docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
echo ""