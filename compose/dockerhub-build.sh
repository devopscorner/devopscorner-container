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
# export IMAGE=$4

docker_build() {
  export TAGS_ID=$1
  export PATH_DOCKERFILE="docker/cicd-$1"
  export FILE=$2
  export CUSTOM_TAGS=$3

  cd $PATH_DOCKERFILE
  if [ "$CUSTOM_TAGS" = "" ]; then
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo ">> docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .
  else
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo "docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .

    echo "Build Image => $IMAGE:${TAGS_ID}-${CUSTOM_TAGS}"
    docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE .
    echo ">> docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE ."
  fi
  cd ../../
}

main() {
  # docker_build alpine Dockerfile 3.16 docker/cicd-alpine/Dockerfile
  # docker_build ubuntu Dockerfile 22.04 docker/cicd-ubuntu/Dockerfile
  # docker_build codebuild Dockerfile 4.0 docker/cicd-codebuild/Dockerfile
  docker_build $1 $2 $3 $4
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $1 $2 $3 $4
