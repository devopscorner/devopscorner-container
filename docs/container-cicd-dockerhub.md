# DevOpsCorner Docker Container - DockerHub

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
  git clone https://github.com/devopscorner/devopscorner-container.git
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
  ```

- Execute Build Image

  - Alpine

    ```
    cd ${PATH_DOCKER}/cicd-alpine && docker build -f Dockerfile -t $IMAGE:alpine .

    -- or --

    # default: 3.16
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh alpine Dockerfile ${ALPINE_VERSION}
    # version: 3.15
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh alpine Dockerfile-Alpine-3.15 3.15
    # version: 3.16
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh alpine Dockerfile-Alpine-3.16 3.16

    -- or --

    # default: 3.16
    make dockerhub-build-alpine
    ```

  - Ubuntu

    ```
    cd ${PATH_DOCKER}/cicd-ubuntu && docker build -f Dockerfile -t $IMAGE:ubuntu .

    -- or --

    # default: 22.04
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile ${UBUNTU_VERSION}
    # version: 16.04
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile-Ubuntu-16.04 16.04
    # version: 18.04
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile-Ubuntu-18.04 18.04
    # version: 20.04
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile-Ubuntu-20.04 20.04
    # version: 22.04
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile-Ubuntu-22.04 22.04

    -- or --

    # default: 22.04
    make dockerhub-build-ubuntu
    ```

  - CodeBuild

    ```
    cd ${PATH_DOCKER}/cicd-codebuild && docker build -f Dockerfile -t $IMAGE:codebuild .

    -- or --

    # default: 4.0
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh codebuild Dockerfile ${CODEBUILD_VERSION}
    # version: 2.0
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh codebuild Dockerfile-CodeBuild-2.0 2.0
    # version: 3.0
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh codebuild Dockerfile-CodeBuild-3.0 3.0
    # version: 4.0
    cd ${PATH_COMPOSE} && ./dockerhub-build.sh codebuild Dockerfile-CodeBuild-4.0 4.0

    -- or --

    # default: 4.0
    make dockerhub-build-codebuild
    ```

## Push Image to DockerHub

- Login to your DockerHub Account

- Add Environment Variable

  ```
  export DOCKERHUB_USERNAME=[YOUR_DOCKERHUB_USERNAME]
  export DOCKERHUB_PASSWORD=[YOUR_DOCKERHUB_PASSWORD_OR_PERSONAL_TOKEN]
  ```

- Create Tags Image

  - Alpine

    ```
    docker tag ${IMAGE}:alpine ${IMAGE}:alpine-latest
    docker tag ${IMAGE}:alpine ${IMAGE}:alpine-3.16
    docker tag ${IMAGE}:alpine ${IMAGE}:alpine-nginx-1.23
    ```

  - Ubuntu

    ```
    docker tag ${IMAGE}:ubuntu ${IMAGE}:ubuntu-latest
    docker tag ${IMAGE}:ubuntu ${IMAGE}:ubuntu-22.04
    docker tag ${IMAGE}:ubuntu ${IMAGE}:ubuntu-nginx-1.23
    ```

  - CodeBuild

    ```
    docker tag ${IMAGE}:codebuild ${IMAGE}:latest
    docker tag ${IMAGE}:codebuild ${IMAGE}:codebuild-latest
    docker tag ${IMAGE}:codebuild ${IMAGE}:codebuild-4.0
    ```

- Create Image Tags for Automation

  - Alpine

    ```
    # default: 3.16
    ./dockerhub-tag.sh alpine ${ALPINE_VERSION}

    -- or --

    make dockerhub-tag-alpine
    ```

  - Ubuntu

    ```
    # default: 22.04
    ./dockerhub-tag.sh ubuntu ${UBUNTU_VERSION}

    -- or --

    # default: 22.04
    make dockerhub-tag-ubuntu
    ```

  - CodeBuild

    ```
    # default: 4.0
    ./dockerhub-tag.sh codebuild ${CODEBUILD_VERSION}

    -- or --

    # default: 4.0
    make dockerhub-tag-codebuild
    ```

- Push Image to **DockerHub** with Tags

  - Alpine

    ```
    docker push devopscorner/cicd:alpine
    docker push devopscorner/cicd:alpine-latest
    docker push devopscorner/cicd:alpine-3.16
    docker push devopscorner/cicd:alpine-nginx-1.23

    -- or --

    ./dockerhub-push.sh alpine CI_PATH="devopscorner/cicd"

    -- or --

    make dockerhub-push-alpine
    ```

  - Ubuntu

    ```
    docker push devopscorner/cicd:ubuntu
    docker push devopscorner/cicd:ubuntu-latest
    docker push devopscorner/cicd:ubuntu-22.04
    docker push devopscorner/cicd:ubuntu-nginx-1.23

    -- or --

    ./dockerhub-push.sh ubuntu CI_PATH="devopscorner/cicd"

    -- or --

    make dockerhub-push-ubuntu
    ```

  - CodeBuild

    ```
    docker push devopscorner/cicd:latest
    docker push devopscorner/cicd:codebuild
    docker push devopscorner/cicd:codebuild-latest
    docker push devopscorner/cicd:codebuild-2.0
    docker push devopscorner/cicd:codebuild-3.0
    docker push devopscorner/cicd:codebuild-4.0

    -- or --

    ./dockerhub-push.sh codebuild CI_PATH="devopscorner/cicd"

    -- or --

    make dockerhub-push-codebuild
    ```
