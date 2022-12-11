#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build, Tag & Push Container for DockerHub
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache v2
# -----------------------------------------------------------------------------

export PATH_COMPOSE='compose'
export PATH_DOCKER='docker'

export CONTAINER_ALPINE="cicd-alpine"
export CONTAINER_UBUNTU="cicd-ubuntu"
export CONTAINER_CODEBUILD="cicd-codebuild"

export IMAGE="devopscorner/cicd"

cd $PATH_COMPOSE/$PATH_DOCKER/$CONTAINER_ALPINE
echo "Build Image => $IMAGE:alpine"
docker build --no-cache -f Dockerfile -t $IMAGE:alpine .
cd ../../../

cd $PATH_COMPOSE/$PATH_DOCKER/$CONTAINER_UBUNTU
echo "Build Image => $IMAGE:ubuntu"
docker build --no-cache -f Dockerfile -t $IMAGE:ubuntu .
cd ../../../

cd $PATH_COMPOSE/$PATH_DOCKER/$CONTAINER_CODEBUILD
echo "Build Image => $IMAGE:codebuild"
docker build --no-cache -f Dockerfile -t $IMAGE:codebuild .
cd ../../../

cd $PATH_COMPOSE
# ./dockerhub-tag.sh devopscorner/cicd [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
./dockerhub-tag.sh devopscorner/cicd alpine 3.16 &&
    ./dockerhub-tag.sh devopscorner/cicd ubuntu 22.04 &&
    ./dockerhub-tag.sh devopscorner/cicd codebuild 4.0 &&

    # ./dockerhub-push.sh devopscorner/cicd [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
    ./dockerhub-push.sh devopscorner/cicd latest &&
    ./dockerhub-push.sh devopscorner/cicd alpine &&
    ./dockerhub-push.sh devopscorner/cicd ubuntu &&
    ./dockerhub-push.sh devopscorner/cicd codebuild

echo "-- ALL DONE --"
