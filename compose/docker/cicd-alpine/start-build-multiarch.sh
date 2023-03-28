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

build_alpine_315() {
    # DEPRECIATED for Alpine-3.15 ##
    TAG="alpine-3.15-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --push \
        --platform $PLATFORM \
        -f Dockerfile-Alpine-3.15-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.15 \
        alpine-3.15-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $PLATFORM \
            -f Dockerfile-Alpine-3.15-AWX \
            -t $IMAGE:$TAG .
        echo ''
    done
}

build_alpine_316() {
    TAG="alpine-3.16-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --push \
        --platform $PLATFORM \
        -f Dockerfile-Alpine-3.16-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.16 \
        alpine-3.16-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $PLATFORM \
            -f Dockerfile-Alpine-3.16-AWX \
            -t $IMAGE:$TAG .
        echo ''
    done
}

build_alpine_317() {
    TAG="alpine-3.17-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker buildx build --push \
        --platform $PLATFORM \
        -f Dockerfile-Alpine-3.17-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.17 \
        alpine-3.17-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $PLATFORM \
            -f Dockerfile-Alpine-3.17-AWX \
            -t $IMAGE:$TAG .
        echo ''
    done
}

build_alpine_latest() {
    TAGS="alpine \
        alpine-nginx-1.23 \
        alpine-latest \
        1.23-alpine \
        latest "

    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker buildx build --push \
            --platform $PLATFORM \
            -f Dockerfile \
            -t $IMAGE:$TAG .
        echo ''
    done
}

docker_build() {
    # Depreciated Alpine-3.15
    # build_alpine_315
    build_alpine_316
    build_alpine_317
    build_alpine_latest
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