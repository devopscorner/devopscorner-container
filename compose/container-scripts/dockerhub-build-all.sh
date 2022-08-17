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

docker_build() {
  export TAGS_ID=$1
  export FILE=$2
  export CUSTOM_TAGS=$3
  export PATH_DOCKERFILE="docker/cicd-$1"

  cd $PATH_DOCKERFILE
  if [ "$CUSTOM_TAGS" = "" ]; then
    echo "Build Image => $IMAGE:${TAGS_ID}"
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .
  else
    echo "Build Image => $IMAGE:${CUSTOM_TAGS}"
    docker build -t $IMAGE:${CUSTOM_TAGS} -f $FILE .
  fi
  cd ../../
}

main() {
  docker_build alpine Dockerfile
  docker_build alpine Dockerfile-Alpine-3.15 alpine-3.15
  docker_build alpine Dockerfile-Alpine-3.16 alpine-3.16
  docker_build ubuntu Dockerfile
  docker_build ubuntu Dockerfile-Ubuntu-20.04 ubuntu-20.04
  docker_build ubuntu Dockerfile-Ubuntu-22.04 ubuntu-22.04
  docker_build codebuild Dockerfile
  docker_build codebuild Dockerfile-CodeBuild-2.0 codebuild-2.0
  docker_build codebuild Dockerfile-CodeBuild-3.0 codebuild-3.0
  docker_build codebuild Dockerfile-CodeBuild-4.0 codebuild-4.0
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $@
