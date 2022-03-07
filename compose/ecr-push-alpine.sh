#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (ECR)
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
export BASE_IMAGE="$IMAGE:alpine"
export TAGS="latest \
  1.0.3 \
  1.0.3-alpine \
  alpine-latest \
  alpine-3.15 \
  alpine
"

echo "Login ECR"
echo ">> docker login -u AWS -p $(aws ecr get-login-password --region ap-southeast-1) $AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com"
docker login -u AWS -p $(aws ecr get-login-password --region ap-southeast-1) $AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
echo "- DONE -"
echo ""

for TAG in $TAGS; do
  echo "Docker Push => $IMAGE:$TAG"
  echo ">> docker push $IMAGE:$TAG"
  docker push $IMAGE:$TAG
  echo "- DONE -"
  echo ""
done

echo ""
echo "-- ALL DONE --"
