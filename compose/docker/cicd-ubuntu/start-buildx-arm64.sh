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
export TARGETPLATFORM="linux/arm64"
export LINUX_ARCH_PATH="arch-arm64"

export STACKS_NAME="devopscorner-arm64"
# List TARGETPLATFORM:
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

build_ubuntu_2004() {
    TAG="ubuntu-20.04"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --push \
        --platform $TARGETPLATFORM \
        -f $LINUX_ARCH_PATH/Dockerfile-Ubuntu-20.04 \
        -t $IMAGE:$TAG .
    echo ''
}

build_ubuntu_2204() {
    TAG="ubuntu-22.04"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --push \
        --platform $TARGETPLATFORM \
        -f $LINUX_ARCH_PATH/Dockerfile-Ubuntu-22.04 \
        -t $IMAGE:$TAG .
    echo ''
}

build_ubuntu_latest() {
    TAGS="ubuntu \
        ubuntu-nginx-1.23 \
        ubuntu-latest \
        1.23-ubuntu "

    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $TARGETPLATFORM \
            -f $LINUX_ARCH_PATH/Dockerfile \
            -t $IMAGE:$TAG .
        echo ''
    done
}

docker_build() {
    build_ubuntu_2004
    build_ubuntu_2204
    build_ubuntu_latest
}

docker_clean() {
    echo "Cleanup Unknown Tags"
    echo "docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi"
    docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi
    echo ''
}

main() {
    # create_stack
    use_stack
    docker_build
    docker_clean
    echo ''
    echo '-- ALL DONE --'
}

### START HERE ###
main