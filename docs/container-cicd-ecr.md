# DevOpsCorner Docker Container - Amazon ECR (Elastic Container Registry)

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![docker pulls](https://img.shields.io/docker/pulls/devopscorner/cicd.svg)](https://hub.docker.com/r/devopscorner/cicd/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/devopscorner-container/blob/main/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

Docker Container Images Repository for DevOpsCorner.id

---

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)

## Build Container Image

- Clone this repository

  ```
  git clone https://github.com/devopscorner/cicd.git
  ```

- Replace "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID

  ```
  find ./ -type f -exec sed -i 's/YOUR_AWS_ACCOUNT/123456789012/g' {} \;
  ```

- Set Environment Variable

  ```
  export ALPINE_VERSION=3.16
  export UBUNTU_VERSION=22.04
  export CODEBUILD_VERSION=4.0

  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"
  export BASE_IMAGE="alpine"  ## alpine | ubuntu | codebuild
  export TAG="latest"

  export IMAGE="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd"
  ```

- Execute Build Image

  - Alpine

    ```
    cd ${PATH_DOCKER}/cicd-alpine && docker build -f Dockerfile -t $IMAGE:alpine .

    -- or --

    # default: 3.16
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT alpine Dockerfile ${ALPINE_VERSION}

    # version: 3.15
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT alpine Dockerfile-Alpine-3.15 3.15

    # version: 3.16
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT alpine Dockerfile-Alpine-3.16 3.16

    -- or --

    # default: 3.16
    make ecr-build-alpine ARGS=YOUR_AWS_ACCOUNT
    ```

  - Ubuntu

    ```
    cd ${PATH_DOCKER}/cicd-ubuntu && docker build -f Dockerfile -t $IMAGE:ubuntu .

    -- or --

    # default: 22.04
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile ${UBUNTU_VERSION}

    # version: 16.04
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile-Ubuntu-16.04 16.04

    # version: 18.04
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile-Ubuntu-18.04 18.04

    # version: 20.04
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile-Ubuntu-20.04 20.04

    # version: 22.04
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT ubuntu Dockerfile-Ubuntu-22.04 22.04

    -- or --

    # default: 22.04
    make ecr-build-ubuntu ARGS=YOUR_AWS_ACCOUNT
    ```

  - CodeBuild

    ```
    cd ${PATH_DOCKER}/cicd-codebuild && docker build -f Dockerfile -t $IMAGE:codebuild .

    -- or --

    # default: 4.0
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile ${CODEBUILD_VERSION}

    # version: 2.0
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile-CodeBuild-2.0 2.0

    # version: 3.0
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile-CodeBuild-3.0 3.0

    # version: 4.0
    cd ${PATH_COMPOSE} && ./ecr-build.sh YOUR_AWS_ACCOUNT codebuild Dockerfile-CodeBuild-4.0 4.0

    -- or --

    # default: 4.0
    make ecr-build-codebuild ARGS=YOUR_AWS_ACCOUNT
    ```

## Push Image to Amazon ECR (Elastic Container Registry)

- Create Image Tags

  - Alpine

    ```
    # default: alpine-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-latest

    # version: 3.16
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-3.16

    # version: alpine-nginx-1.23
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-nginx-1.23
    ```

  - Ubuntu

    ```
    # default: ubuntu-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-latest

    # version: 22.04
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-22.04

    # version: ubuntu-nginx-1.23
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-nginx-1.23
    ```

  - CodeBuild

    ```
    # default: latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:latest

    # version: codebuild-latest
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild-latest

    # version: 4.0
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild-4.0

    # version: codebuild-nginx-1.23
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild-nginx-1.23
    ```

- Create Image Tags for Automation

  - Alpine

    ```
    # default: 3.16
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT alpine ${ALPINE_VERSION} CI_PATH=devopscorner/cicd

    -- or --

    make ecr-tag-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/cicd
    ```

  - Ubuntu

    ```
    # default: 22.04
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT ubuntu ${UBUNTU_VERSION} CI_PATH=devopscorner/cicd

    -- or --

    make ecr-tag-ubuntu ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/cicd
    ```

  - CodeBuild

    ```
    # default: 4.0
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT codebuild ${CODEBUILD_VERSION} CI_PATH=devopscorner/cicd

    -- or --

    make ecr-tag-codebuild ARGS=YOUR_AWS_ACCOUNT CI_PATH=devopscorner/cicd
    ```

- Push Image to **Amazon ECR** with Tags

  - Alpine

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-latest

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-3.16

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine-nginx-1.23

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT alpine CI_PATH="devopscorner/cicd"

    -- or --

    make ecr-push-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/cicd"
    ```

  - Ubuntu

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-latest

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-22.04

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu-nginx-1.23

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT ubuntu CI_PATH="devopscorner/cicd"

    -- or --

    make ecr-push-ubuntu ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/cicd"
    ```

  - CodeBuild

    ```
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:latest

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild-latest

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild-4.0

    -- or --

    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT codebuild CI_PATH="devopscorner/cicd"

    -- or --

    make ecr-push-codebuild ARGS=YOUR_AWS_ACCOUNT CI_PATH="devopscorner/cicd"
    ```
