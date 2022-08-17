#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (DockerHub)
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT_ID=$1
export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_ECR_PATH="devopscorner/cicd"

export IMAGE="$CI_REGISTRY/$CI_ECR_PATH"

login_ecr() {
  echo "============="
  echo "  Login ECR  "
  echo "============="
  PASSWORD=`aws ecr get-login-password --region ap-southeast-1`
  echo $PASSWORD | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com
  echo '- DONE -'
  echo ''
}

docker_build() {
  export TAGS_ID=$2
  export PATH_DOCKERFILE="docker/cicd-$2"
  export FILE=$3
  export CUSTOM_TAGS=$4

  cd $PATH_DOCKERFILE
  if [ "$CUSTOM_TAGS" = "" ]; then
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo "docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .
  else
    echo "Build Image => $IMAGE:${TAGS_ID}"
    echo "docker build -t $IMAGE:${TAGS_ID} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID} -f $FILE .

    echo "Build Image => $IMAGE:${TAGS_ID}-${CUSTOM_TAGS}"
    echo "docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE ."
    docker build -t $IMAGE:${TAGS_ID}-${CUSTOM_TAGS} -f $FILE .
  fi
  cd ../../
}

main() {
  # login_ecr
  # docker_build 0987654321 alpine Dockerfile alpine-3.16
  # docker_build 0987654321 ubuntu Dockerfile ubuntu-22.04
  # docker_build 0987654321 codebuild Dockerfile codebuild-4.0
  docker_build $1 $2 $3 $4
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $1 $2 $3 $4
