#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (DockerHub)
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export BASE_IMAGE="$IMAGE:ubuntu"
export TAGS="latest
  1.0.4 \
  1.0.4-ubuntu \
  ubuntu-latest \
  ubuntu-20.04 \
  ubuntu
"

echo "==================="
echo "  Login DockerHub  "
echo "==================="
echo ${DOCKERHUB_PASSWORD} | docker login --username ${DOCKERHUB_USERNAME} --password-stdin
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
