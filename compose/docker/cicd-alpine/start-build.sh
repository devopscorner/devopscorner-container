#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  Docker Build Container
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni
#  License    : Apache v2
# -----------------------------------------------------------------------------
set -e

export CI_PROJECT_PATH="devopscorner"
export CI_PROJECT_NAME="cicd"

export IMAGE="$CI_PROJECT_PATH/$CI_PROJECT_NAME"

build_alpine_315() {
    # DEPRECIATED for Alpine-3.15 ##
    TAG="alpine-3.15-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-Alpine-3.15-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.15 \
        alpine-3.15-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker build \
            -f Dockerfile-Alpine-3.15-AWX \
            -t $IMAGE:$TAG .
        echo ''
    done
}

build_alpine_316() {
    TAG="alpine-3.16-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-Alpine-3.16-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.16 \
        alpine-3.16-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker build \
            -f Dockerfile-Alpine-3.16-AWX \
            -t $IMAGE:$TAG .
        echo ''
    done
}

build_alpine_317() {
    TAG="alpine-3.17-AnsibleTower"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-Alpine-3.17-Ansible-Tower \
        -t $IMAGE:$TAG .
    echo ''

    TAGS="alpine-3.17 \
        alpine-3.17-AWX "
    for TAG in $TAGS; do
        echo " Build Image => $IMAGE:$TAG"
        docker build \
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
        docker build \
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
    docker_build
    docker_clean
    echo ''
    echo '-- ALL DONE --'
}

### START HERE ###
main