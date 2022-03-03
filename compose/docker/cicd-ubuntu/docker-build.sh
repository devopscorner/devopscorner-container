#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT="YOUR_AWS_ACCOUNT"
export CI_REGISTRY="$AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export TAG="ubuntu"

echo " Build Image => $IMAGE:$TAG"
docker build . -t $IMAGE:$TAG
