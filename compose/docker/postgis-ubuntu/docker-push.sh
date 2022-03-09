#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT_ID="YOUR_AWS_ACCOUNT"
export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="postgis"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export TAG="11-2.5-ubuntu"

echo " Push Image => $IMAGE:$TAG"
docker push $IMAGE:$TAG
