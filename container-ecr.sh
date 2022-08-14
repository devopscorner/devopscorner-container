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

export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_ECR_PATH="devopscorner/cicd"

export IMAGE="$CI_REGISTRY/$CI_ECR_PATH"

docker build -f $CONTAINER_ALPINE/Dockerfile -t $IMAGE:alpine . &&\
docker build -f $CONTAINER_CODEBUILD/Dockerfile -t $IMAGE:codebuild . &&\
docker build -f $CONTAINER_UBUNTU/Dockerfile -t $IMAGE:ubuntu . &&\

./ecr-tag-alpine.sh &&\
./ecr-tag-codebuild.sh &&\
./ecr-tag-ubuntu.sh &&\
./ecr-push-alpine.sh &&\
./ecr-push-codebuild.sh &&\
./ecr-push-ubuntu.sh \
