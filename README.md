# DevOpsCorner Docker Container

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

  -- or --

  cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh
  cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh

  -- or --

  make build-cicd-ubuntu
  make build-cicd-alpine
  ```

### Push Image to ECR

- Create Tags Image

  ```
  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"

  cd ${PATH_DOCKER}/cicd-ubuntu && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-alpine && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG

  -- or --

  cd ${PATH_COMPOSE} && ./ecr-tag-ubuntu.sh
  cd ${PATH_COMPOSE} && ./ecr-tag-alpine.sh

  -- or --

  make ecr-tag-ubuntu
  make ecr-tag-alpine
  ```

- Push Image with Tags

  ```
  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"

  cd ${PATH_DOCKER}/cicd-ubuntu && docker push $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-alpine && docker push $IMAGE:$TAG

  -- or --

  cd ${PATH_COMPOSE} && ./ecr-push-ubuntu.sh
  cd ${PATH_COMPOSE} && ./ecr-push-alpine.sh

  -- or --

  make ecr-push-ubuntu
  make ecr-push-alpine
  ```

### Push Image to DockerHub

- Login to your DockerHub Account
- Create Tags Image

  ```
  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"

  cd ${PATH_DOCKER}/cicd-ubuntu && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-alpine && docker tag $BASE_IMAGE:$TAG $IMAGE:$TAG

  -- or --

  cd ${PATH_COMPOSE} && ./dockerhub-tag-ubuntu.sh
  cd ${PATH_COMPOSE} && ./dockerhub-tag-alpine.sh

  -- or --

  make dockerhub-tag-ubuntu
  make dockerhub-tag-alpine
  ```

- Push Image with Tags

  ```
  export PATH_COMPOSE="compose"
  export PATH_DOCKER="$PATH_COMPOSE/docker"

  cd ${PATH_DOCKER}/cicd-ubuntu && docker push $IMAGE:$TAG
  cd ${PATH_DOCKER}/cicd-alpine && docker push $IMAGE:$TAG

  -- or --

  cd ${PATH_COMPOSE} && ./dockerhub-push-ubuntu.sh
  cd ${PATH_COMPOSE} && ./dockerhub-push-alpine.sh

  -- or --

  make dockerhub-push-ubuntu
  make dockerhub-push-alpine
  ```

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
