#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Push Container (Elastic Container Registry - ECR)
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export AWS_ACCOUNT_ID=$1
export CI_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com"
export CI_ECR_PATH=$2

export IMAGE="$CI_REGISTRY/$CI_ECR_PATH"

login_ecr() {
  echo "============="
  echo "  Login ECR  "
  echo "============="
  PASSWORD=$(aws ecr get-login-password --region ap-southeast-1)
  echo $PASSWORD | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-southeast-1.amazonaws.com
  echo '- DONE -'
  echo ''
}

docker_push() {
  export TAGS_ID=$3
  IMAGES=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep $IMAGE:$TAGS_ID)
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
  # docker_push [AWS_ACCOUNT] devopscorner/airflow [alpine|ubuntu|version|latest|tags|custom-tags]
  docker_push $1 $2 $3
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $1 $2 $3

### How to Execute ###
# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|version|latest|tags|custom-tags]
