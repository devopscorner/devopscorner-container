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

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export CICD_VERSION="1.0.5"
export ALPINE_VERSION="3.16"
export UBUNTU_VERSION="22.04"
export CODEBUILD_VERSION="4.0"

login_ecr() {
  echo "============="
  echo "  Login ECR  "
  echo "============="
  PASSWORD=`aws ecr get-login-password --region ap-southeast-1`
  echo $PASSWORD | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com
  echo '- DONE -'
  echo ''
}

docker_push() {
  export TAGS_ID=$1
  IMAGES=`docker images --format "{{.Repository}}:{{.Tag}}" | grep $IMAGE:${TAGS_ID}`

  for IMG in $IMAGES; do
    echo "Docker Push => $IMG"
    echo ">> docker push $IMG"
    docker push $IMG
    echo '- DONE -'
    echo ''
  done
}

main() {
  login_ecr
  docker_push alpine
  docker_push ubuntu
  docker_push codebuild
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $@
