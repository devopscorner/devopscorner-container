#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Tags
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_REGISTRY="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_REGISTRY/$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export BASE_IMAGE="$IMAGE:alpine"
export TAGS="latest \
  1.0.3 \
  1.0.3-alpine \
  alpine-latest \
  alpine-3.15
"

echo "Login ECR"
echo ">> aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com"
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
echo "- DONE -"
echo ""

for TAG in $TAGS; do
  echo "Docker Tags => $IMAGE:$TAG"
  echo ">> docker tag $BASE_IMAGE $IMAGE:$TAG"
  docker tag $BASE_IMAGE $IMAGE:$TAG
  echo "- DONE -"
  echo ""
done

echo ""
echo "-- ALL DONE --"
