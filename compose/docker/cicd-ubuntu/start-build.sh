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

build_ubuntu_2004() {
    TAG="ubuntu-20.04"
    echo " Build Image => $IMAGE:$TAG"
    docker build --no-cache -f Dockerfile-Ubuntu-20.04 -t $IMAGE:$TAG .
    echo ''
}

build_ubuntu_2204() {
    TAG="ubuntu-22.04"
    echo " Build Image => $IMAGE:$TAG"
    docker build --no-cache -f Dockerfile-Ubuntu-22.04 -t $IMAGE:$TAG .
    echo ''
}

build_ubuntu_latest() {
    TAG="ubuntu-nginx-1.23"
    echo " Build Image => $IMAGE:$TAG"
    docker build --no-cache -f Dockerfile -t $IMAGE:$TAG .
    docker tag $IMAGE:$TAG $IMAGE:ubuntu
    docker tag $IMAGE:$TAG $IMAGE:ubuntu-latest
    docker tag $IMAGE:$TAG $IMAGE:1.23-ubuntu
    # docker tag $IMAGE:$TAG $IMAGE:latest
    echo ''
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
    docker_build
    docker_clean
    echo ''
    echo '-- ALL DONE --'
}

### START HERE ###
main
