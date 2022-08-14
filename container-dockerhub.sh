#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build, Tag & Push Container for DockerHub
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache v2
# -----------------------------------------------------------------------------

export PATH_COMPOSE='compose'
export PATH_DOCKER='docker'

export CONTAINER_ALPINE="$PATH_COMPOSE/$PATH_DOCKER/cicd-alpine"
export CONTAINER_CODEBUILD="$PATH_COMPOSE/$PATH_DOCKER/cicd-codebuild"
export CONTAINER_UBUNTU="$PATH_COMPOSE/$PATH_DOCKER/cicd-ubuntu"

export IMAGE="devopscorner/cicd"

docker build -f $CONTAINER_ALPINE/Dockerfile -t $IMAGE:alpine . &&\
docker build -f $CONTAINER_CODEBUILD/Dockerfile -t $IMAGE:codebuild . &&\
docker build -f $CONTAINER_UBUNTU/Dockerfile -t $IMAGE:ubuntu . &&\

./dockerhub-tag-alpine.sh &&\
./dockerhub-tag-codebuild.sh &&\
./dockerhub-tag-ubuntu.sh &&\
./dockerhub-push-alpine.sh &&\
./dockerhub-push-codebuild.sh &&\
./dockerhub-push-ubuntu.sh \
