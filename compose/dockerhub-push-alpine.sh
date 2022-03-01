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
export BASE_IMAGE="$IMAGE:alpine"
export TAGS="latest \
  1.0.3 \
  1.0.3-alpine \
  alpine-latest \
  alpine-3.15 \
  alpine
"

for TAG in $TAGS; do
  echo "Docker Push => $IMAGE:$TAG"
  echo ">> docker push $IMAGE:$TAG"
  docker push $IMAGE:$TAG
  echo "- DONE -"
  echo ""
done

echo ""
echo "-- ALL DONE --"
