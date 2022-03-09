#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT_ID="YOUR_AWS_ACCOUNT"
export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="mariadb"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export TAG="10.5.12-alpine"

echo " Build Image => $IMAGE:$TAG"
docker build . -t $IMAGE:$TAG