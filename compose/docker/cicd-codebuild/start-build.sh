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
docker tag $IMAGE:$TAG $IMAGE:codebuild
docker tag $IMAGE:$TAG $IMAGE:codebuild-latest
docker tag $IMAGE:$TAG $IMAGE:1.23-codebuild
docker tag $IMAGE:$TAG $IMAGE:latest
echo ""

# TAG="codebuild-5.0"
# echo " Build Image => $IMAGE:$TAG"
# docker build --no-cache -f Dockerfile-CodeBuild-5.0 -t $IMAGE:$TAG .
# docker tag $IMAGE:$TAG $IMAGE:codebuild
# docker tag $IMAGE:$TAG $IMAGE:codebuild-latest
# docker tag $IMAGE:$TAG $IMAGE:1.23-codebuild
# docker tag $IMAGE:$TAG $IMAGE:latest
# echo ""

echo "Cleanup Unknown Tags"
echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
echo ""

echo "-- ALL DONE --"
