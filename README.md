# DevOpsCorner Docker Container

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![docker pulls](https://img.shields.io/docker/pulls/devopscorner/cicd.svg)](https://hub.docker.com/r/devopscorner/cicd/)
[![docker image size](https://img.shields.io/docker/image-size/devopscorner/cicd.svg?sort=date)](https://hub.docker.com/r/devopscorner/cicd/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/2.3/total)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/devopscorner-container/blob/main/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

Docker Container Images Repository for DevOpsCorner.id

### Build Container Image

- Clone this repository

  ```
  git clone https://github.com/devopscorner/devopscorner-container.git
  ```

- Replace "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID

  ```
  find ./ -type f -exec sed -i 's/YOUR_AWS_ACCOUNT/123456789012/g' {} \;
  ```

- Execute Build Image

  ```
  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"

  cd ${PATH_DOCKER}/cicd-ubuntu && docker build . -t $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-alpine && docker build . -t $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-codebuild && docker build . -t $IMAGE:$TAG

  -- or --

  cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh
  cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh
  cd ${PATH_DOCKER}/cicd-codebuild && ./docker-build.sh

  -- or --

  make build-cicd-ubuntu
  make build-cicd-alpine
  make build-cicd-codebuild
  ```

### Push Image to ECR

- Create Tags Image
  - Example:

    ```
    # Ubuntu

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:latest

    # Alpine

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:latest

    # CodeBuild

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:latest
    ```

  - With Script:

    ```
    export PATH_COMPOSE="compose"
    export PATH_DOCKER="$PATH_COMPOSE/docker"

    cd ${PATH_DOCKER}/cicd-ubuntu && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-alpine && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-codebuild && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG

    -- or --

    cd ${PATH_COMPOSE} && ./ecr-tag-ubuntu.sh ARGS=YOUR_AWS_ACCOUNT
    cd ${PATH_COMPOSE} && ./ecr-tag-alpine.sh ARGS=YOUR_AWS_ACCOUNT
    cd ${PATH_COMPOSE} && ./ecr-tag-codebuild.sh ARGS=YOUR_AWS_ACCOUNT

    -- or --

    make ecr-tag-ubuntu ARGS=YOUR_AWS_ACCOUNT
    make ecr-tag-alpine ARGS=YOUR_AWS_ACCOUNT
    make ecr-tag-codebuild ARGS=YOUR_AWS_ACCOUNT
    ```

- Push Image with Tags
  - Example:

    ```
    # Ubuntu

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu

    # Alpine

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine

    # CodeBuild

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:codebuild
    ```

  - With Script:

    ```
    export PATH_COMPOSE="compose"
    export PATH_DOCKER="$PATH_COMPOSE/docker"

    cd ${PATH_DOCKER}/cicd-ubuntu && docker push $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-alpine && docker push $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-codebuild && docker push $IMAGE:$TAG

    -- or --

    cd ${PATH_COMPOSE} && ./ecr-push-ubuntu.sh ARGS=YOUR_AWS_ACCOUNT
    cd ${PATH_COMPOSE} && ./ecr-push-alpine.sh ARGS=YOUR_AWS_ACCOUNT
    cd ${PATH_COMPOSE} && ./ecr-push-codebuild.sh ARGS=YOUR_AWS_ACCOUNT

    -- or --

    make ecr-push-ubuntu ARGS=YOUR_AWS_ACCOUNT
    make ecr-push-alpine ARGS=YOUR_AWS_ACCOUNT
    make ecr-push-codebuild ARGS=YOUR_AWS_ACCOUNT
    ```

### Push Image to DockerHub

- Login to your DockerHub Account
- Create Tags Image
  - Example:

    ```
    # Ubuntu (Latest)

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:ubuntu devopscorner/cicd:ubuntu

    # Alpine (Latest)

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine devopscorner/cicd:alpine

    # CodeBuild (Latest)

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/cicd:alpine devopscorner/cicd:codebuild
    ```

  - With Script:

    ```
    export PATH_COMPOSE="compose"
    export PATH_DOCKER="$PATH_COMPOSE/docker"

    cd ${PATH_DOCKER}/cicd-ubuntu && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-alpine && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-codebuild && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG

    -- or --

    cd ${PATH_COMPOSE} && ./dockerhub-tag-ubuntu.sh
    cd ${PATH_COMPOSE} && ./dockerhub-tag-alpine.sh
    cd ${PATH_COMPOSE} && ./dockerhub-tag-codebuild.sh

    -- or --

    make dockerhub-tag-ubuntu
    make dockerhub-tag-alpine
    make dockerhub-tag-codebuild
    ```

- Push Image with Tags

  - Example:

    ```
    # Ubuntu

    docker push devopscorner-cicd:ubuntu

    # Alpine

    docker push devopscorner-cicd:alpine

    # CodeBuild

    docker push devopscorner-cicd:alpine

    # Latest (Ubuntu / Alpine / CodeBuild)

    docker push devopscorner-cicd:latest
    ```

  - With Script:

    ```
    export PATH_COMPOSE="compose"
    export PATH_DOCKER="$PATH_COMPOSE/docker"

    cd ${PATH_DOCKER}/cicd-ubuntu && docker push $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-alpine && docker push $IMAGE:$TAG
    cd ${PATH_DOCKER}/cicd-codebuild && docker push $IMAGE:$TAG

    -- or --

    cd ${PATH_COMPOSE} && ./dockerhub-push-ubuntu.sh
    cd ${PATH_COMPOSE} && ./dockerhub-push-alpine.sh
    cd ${PATH_COMPOSE} && ./dockerhub-push-codebuild.sh

    -- or --

    make dockerhub-push-ubuntu
    make dockerhub-push-alpine
    make dockerhub-push-codebuild
    ```

## Available Tags
- Alpine
  ```
  devopscorner/cicd:latest
  devopscorner/cicd:1.0.3
  devopscorner/cicd:1.0.3-alpine
  devopscorner/cicd:1.0.5
  devopscorner/cicd:1.0.5-alpine
  devopscorner/cicd:alpine
  devopscorner/cicd:alpine-latest
  devopscorner/cicd:alpine-3.15
  devopscorner/cicd:alpine-3.16
  ```

- Ubuntu
  ```
  devopscorner/cicd:1.0.3-ubuntu
  devopscorner/cicd:1.0.5-ubuntu
  devopscorner/cicd:ubuntu
  devopscorner/cicd:ubuntu-latest
  devopscorner/cicd:ubuntu-20.04
  devopscorner/cicd:ubuntu-22.04
  ```

- AWS Linux (CodeBuild)
  ```
  devopscorner/cicd:codebuild
  devopscorner/cicd:codebuild-latest
  devopscorner/cicd:codebuild-2.0
  devopscorner/cicd:codebuild-3.0
  devopscorner/cicd:codebuild-4.0
  ```

## Security Check

Make sure that you didn't push sensitive information in this repository

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET_KEY)
- [ ] AWS Account ID
- [ ] AWS Resources ARN
- [ ] Username & Password
- [ ] Private (id_rsa) & Public Key (id_rsa.pub)
- [ ] DNS Zone ID
- [ ] APP & API Key


## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
