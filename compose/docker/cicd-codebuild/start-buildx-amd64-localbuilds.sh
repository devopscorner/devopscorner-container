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

## CodeBuild can't be use for Multi Arch ##
## Using Public ECR:
## public.ecr.aws/codebuild/local-builds:latest
## public.ecr.aws/codebuild/local-builds:aarch64

export TARGETPLATFORM="linux/amd64"
export LINUX_ARCH_PATH="arch-amd64"
export STACKS_NAME="devopscorner-amd64"
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
    docker buildx create --name $STACKS_NAME \
        --driver docker-container \
        --bootstrap
    echo " - DONE -"
    echo ''
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
    echo ''
}

build_codebuild_localbuild_latest() {
    TAGS="codebuild-localbuild \
        codebuild-localbuild-latest \
        1.23-codebuild-localbuild "

    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $TARGETPLATFORM \
            -f $LINUX_ARCH_PATH/Dockerfile-CodeBuild-LocalBuild \
            -t $IMAGE:$TAG .
        echo ''
    done
}

docker_build() {
    build_codebuild_localbuild_latest
}

docker_clean() {
    echo "Cleanup Unknown Tags"
    echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
    docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
    echo ''
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
main