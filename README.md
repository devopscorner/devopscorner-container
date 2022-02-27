# DevOpsCorner Docker Container

Docker Container Images Repository for DevOpsCorner.id

## How-to-Use
- Clone this repository
  ```
  git clone https://github.com/devopscorner/devopscorner-container.git
  ```

### Make Container
```
make build-cicd-ubuntu
make build-cicd-alpine
```

### Push ECR
- Edit "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID
- Run this command in terminal:
  ```
  cd compose

  ## Alpine
  ./ecr-tag-alpine.sh
  ./ecr-push-alpine.sh

  ## Ubuntu
  ./ecr-tag-ubuntu.sh
  ./ecr-push-ubuntu.sh
  ```

### Push Dockerhub
- Login to your Dockerhub Account
- Run this command in terminal:
  ```
  cd compose

  ## Alpine
  ./ecr-tag-alpine.sh
  ./ecr-push-alpine.sh

  ## Ubuntu
  ./ecr-tag-ubuntu.sh
  ./ecr-push-ubuntu.sh
  ```

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
