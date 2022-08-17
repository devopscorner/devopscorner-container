#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build, Tag & Push Container for ECR
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache v2
# -----------------------------------------------------------------------------

export AWS_ACCOUNT_ID=$1
export PATH_COMPOSE='compose'
export PATH_DOCKER='docker'

export CONTAINER_ALPINE="cicd-alpine"
export CONTAINER_CODEBUILD="cicd-codebuild"
export CONTAINER_UBUNTU="cicd-ubuntu"

export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_ECR_PATH="devopscorner/cicd"

export IMAGE="$CI_REGISTRY/$CI_ECR_PATH"

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
./ecr-tag.sh ${AWS_ACCOUNT_ID} alpine 3.16 devopscorner/cicd &&\
./ecr-tag.sh ${AWS_ACCOUNT_ID} ubuntu 22.04 devopscorner/cicd &&\
./ecr-tag.sh ${AWS_ACCOUNT_ID} codebuild 4.0 devopscorner/cicd &&\
./ecr-push.sh ${AWS_ACCOUNT_ID} alpine devopscorner/cicd &&\
./ecr-push.sh ${AWS_ACCOUNT_ID} ubuntu devopscorner/cicd &&\
./ecr-push.sh ${AWS_ACCOUNT_ID} codebuild devopscorner/cicd
