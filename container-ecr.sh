#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build, Tag & Push Container for Elastic Container Registry (ECR)
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
# ./ecr-tag.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
./ecr-tag.sh ${AWS_ACCOUNT_ID} devopscorner/cicd alpine 3.16
./ecr-tag.sh ${AWS_ACCOUNT_ID} devopscorner/cicd ubuntu 22.04
./ecr-tag.sh ${AWS_ACCOUNT_ID} devopscorner/cicd codebuild 4.0

# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
./ecr-push.sh ${AWS_ACCOUNT_ID} devopscorner/cicd latest
./ecr-push.sh ${AWS_ACCOUNT_ID} devopscorner/cicd alpine
./ecr-push.sh ${AWS_ACCOUNT_ID} devopscorner/cicd ubuntu
./ecr-push.sh ${AWS_ACCOUNT_ID} devopscorner/cicd codebuild

echo "-- ALL DONE --"
