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

build_codebuild_20() {
    TAG="codebuild-2.0"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-CodeBuild-2.0 \
        -t $IMAGE:$TAG .
    echo ''
}

build_codebuild_30() {
    TAG="codebuild-3.0"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-CodeBuild-3.0 \
        -t $IMAGE:$TAG .
    echo ''
}

build_codebuild_40() {
    TAG="codebuild-4.0"
    echo " Build Image => $IMAGE:$TAG"
    docker build \
        -f Dockerfile-CodeBuild-4.0 \
        -t $IMAGE:$TAG .
    echo ''
}

build_codebuild_latest() {
    TAGS="codebuild \
        codebuild-nginx-1.23 \
        codebuild-latest \
        1.23-codebuild \
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
    build_codebuild_20
    build_codebuild_30
    build_codebuild_40
    build_codebuild_latest
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