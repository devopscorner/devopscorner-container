#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Tags
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT_ID=$1
export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export BASE_IMAGE="$IMAGE:ubuntu"
export TAGS="latest
  1.0.5 \
  1.0.5-ubuntu \
  ubuntu-latest \
  ubuntu-22.04
"

for TAG in $TAGS; do
  echo "Docker Tags => $IMAGE:$TAG"
  echo ">> docker tag $BASE_IMAGE $IMAGE:$TAG"
  docker tag $BASE_IMAGE $IMAGE:$TAG
  echo "- DONE -"
  echo ""
done

echo ""
echo "-- ALL DONE --"
