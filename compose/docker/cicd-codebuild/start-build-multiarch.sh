#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Multi Architecture Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"
export PLATFORM="linux/amd64,linux/arm64"

export STACKS_NAME="devopscorner-multiarch"
# List PLATFORM:
# docker buildx inspect $STACKS_NAME

line1="----------------------------------------------------------------------------------------------------"
line2="===================================================================================================="

create_stack() {
    echo $line2
    echo " Build Stacks Multiplatform"
    echo " Stacks: $STACKS_NAME"
    echo $line2
    echo " -> docker buildx create --name $STACKS_NAME --driver docker-container --bootstrap"
    echo $line1
    docker buildx create --name $STACKS_NAME --driver docker-container --bootstrap
    echo " - DONE -"
    echo ""
}

use_stack() {
    echo $line2
    echo " Use Stacks Multiplatform"
    echo " Stacks: $STACKS_NAME"
    echo $line2
    echo " -> docker buildx use $STACKS_NAME"
    echo $line1
    docker buildx use $STACKS_NAME
    echo " - DONE -"
    echo ""
}

build_codebuild_20() {
    TAG="codebuild-2.0"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --platform $PLATFORM --no-cache -f Dockerfile-CodeBuild-2.0 -t $IMAGE:$TAG .
    echo ""
}

build_codebuild_30() {
    TAG="codebuild-3.0"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --platform $PLATFORM --no-cache -f Dockerfile-CodeBuild-3.0 -t $IMAGE:$TAG .
    echo ""
}

build_codebuild_40() {
    TAG="codebuild-4.0"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --platform $PLATFORM --no-cache -f Dockerfile-CodeBuild-4.0 -t $IMAGE:$TAG .
    echo ""
}

build_codebuild_50() {
    TAG="codebuild-5.0"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --platform $PLATFORM --no-cache -f Dockerfile-CodeBuild-4.0 -t $IMAGE:$TAG .
    echo ""
}

build_codebuild_latest() {
    TAG="codebuild-nginx-1.23"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --platform $PLATFORM --no-cache -f Dockerfile -t $IMAGE:$TAG .
    docker tag $IMAGE:$TAG $IMAGE:codebuild
    docker tag $IMAGE:$TAG $IMAGE:codebuild-latest
    docker tag $IMAGE:$TAG $IMAGE:1.23-codebuild
    docker tag $IMAGE:$TAG $IMAGE:latest
    echo ""
}

docker_build() {
    build_codebuild_20
    build_codebuild_30
    build_codebuild_40
    #build_codebuild_50
    build_codebuild_latest
}

docker_clean() {
    echo "Cleanup Unknown Tags"
    echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
    docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
    echo ""
}

main() {
  create_stack
  use_stack
  docker_build
  docker_clean
  echo ''
  echo '-- ALL DONE --'
}

### START HERE ###
main $@
