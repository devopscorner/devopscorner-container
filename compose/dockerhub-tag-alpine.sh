#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Tags
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export BASE_IMAGE="$IMAGE:alpine"
export COMMIT_HASH=`git log -1 --format=format:"%H"`
export TAGS="latest \
  1.0.5 \
  1.0.5-alpine \
  alpine-latest \
  alpine-3.16 \
  ${COMMIT_HASH}"

for TAG in $TAGS; do
  echo "Docker Tags => $IMAGE:$TAG"
  echo ">> docker tag $BASE_IMAGE $IMAGE:$TAG"
  docker tag $BASE_IMAGE $IMAGE:$TAG
  echo "- DONE -"
  echo ""
done

echo ""
echo "-- ALL DONE --"
