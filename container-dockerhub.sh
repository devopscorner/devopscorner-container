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
docker build -f Dockerfile -t $IMAGE:alpine .
cd ../../../

cd $PATH_COMPOSE/$PATH_DOCKER/$CONTAINER_UBUNTU
echo "Build Image => $IMAGE:ubuntu"
docker build -f Dockerfile -t $IMAGE:ubuntu .
cd ../../../

cd $PATH_COMPOSE/$PATH_DOCKER/$CONTAINER_CODEBUILD
echo "Build Image => $IMAGE:codebuild"
docker build -f Dockerfile -t $IMAGE:codebuild .
cd ../../../

cd $PATH_COMPOSE
./dockerhub-tag.sh alpine 3.16 devopscorner/cicd &&\
./dockerhub-tag.sh ubuntu 22.04 devopscorner/cicd &&\
./dockerhub-tag.sh codebuild 4.0 devopscorner/cicd &&\
./dockerhub-push.sh alpine devopscorner/cicd &&\
./dockerhub-push.sh ubuntu devopscorner/cicd &&\
./dockerhub-push.sh codebuild devopscorner/cicd
