#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (ECR)
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
  1.0.4 \
  1.0.4-ubuntu \
  ubuntu-latest \
  ubuntu-20.04 \
  ubuntu
"

echo "============="
echo "  Login ECR  "
echo "============="
PASSWORD=`aws ecr get-login-password --region ap-southeast-1`
echo $PASSWORD | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com
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
