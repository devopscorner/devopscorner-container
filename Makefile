# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="compose"
export PATH_DOCKER="$(PATH_COMPOSE)/docker"
export PATH_HELM="$(PATH_COMPOSE)/helm"
export PROJECT_NAME="container"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= cicd

IMAGE   = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR     = $(shell pwd)
VERSION ?= 1.3.0

export BASE_IMAGE=alpine
export BASE_VERSION=3.16

export ALPINE_VERSION=3.16
export UBUNTU_VERSION=22.04
export CODEBUILD_VERSION=4.0

# ==================== #
#   CONTAINER UBUNTU   #
# ==================== #
.PHONY: run stop remove build push push-container
run:
	@echo "========================================================"
	@echo " Task      : Docker Container "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@./run-docker.sh
	@echo '- DONE -'

stop:
	@echo "========================================================"
	@echo " Task      : Stopping Docker Container "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@docker-compose -f ${PATH_COMPOSE}/app-compose.yml stop
	@echo '- DONE -'

.PHONY: build-ubuntu push-ubuntu push-container-ubuntu
# ./dockerhub-build.sh Dockerfile [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh Dockerfile $(CI_PATH) ubuntu ${UBUNTU_VERSION}
	@echo '- DONE -'

# ./dockerhub-push.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Container Image Ubuntu"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh $(CI_PATH) ubuntu
	@echo '- DONE -'

# ./dockerhub-push.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
build-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Build & Push Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "========================================================"s
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh Dockerfile $(CI_PATH) ubuntu ${UBUNTU_VERSION}
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh $(CI_PATH) ubuntu
	@echo '- DONE -'

# ========================= #
#   BUILD CONTAINER CI/CD   #
# ========================= #
.PHONY: build-cicd-alpine build-cicd-ubuntu build-cicd-codebuild
# ./dockerhub-build.sh Dockerfile [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
build-cicd-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh Dockerfile $(CI_PATH) alpine latest
	@echo '- DONE -'

build-cicd-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh Dockerfile $(CI_PATH) ubuntu latest
	@echo '- DONE -'

build-cicd-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-codebuild && ./docker-build.sh Dockerfile $(CI_PATH) codebuild latest
	@echo '- DONE -'

.PHONY: dockerhub-build-alpine dockerhub-build-ubuntu dockerhub-build-codebuild
dockerhub-build-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh Dockerfile $(CI_PATH) alpine ${ALPINE_VERSION}

dockerhub-build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh Dockerfile $(CI_PATH) ubuntu ${UBUNTU_VERSION}

dockerhub-build-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh Dockerfile $(CI_PATH) codebuild ${CODEBUILD_VERSION}

# ./ecr-build.sh [AWS_ACCOUNT] Dockerfile [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
.PHONY: ecr-build-alpine ecr-build-ubuntu ecr-build-codebuild
ecr-build-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) Dockerfile $(CI_PATH) alpine ${ALPINE_VERSION}

ecr-build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) Dockerfile $(CI_PATH) ubuntu ${UBUNTU_VERSION}

ecr-build-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) Dockerfile $(CI_PATH) codebuild ${CODEBUILD_VERSION}

# ======================== #
#   TAGS CONTAINER CI/CD   #
# ======================== #
# ./dockerhub-tag.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
.PHONY: tag-dockerhub-alpine tag-dockerhub-ubuntu tag-dockerhub-codebuild tag-ecr-alpine tag-ecr-ubuntu tag-ecr-codebuild
dockerhub-tag-alpine:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh $(CI_PATH) alpine ${ALPINE_VERSION}

dockerhub-tag-ubuntu:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh $(CI_PATH) ubuntu ${UBUNTU_VERSION}

dockerhub-tag-codebuild:
	@echo "========================================================"
	@echo " Task      : Set Tags Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh $(CI_PATH) codebuild ${CODEBUILD_VERSION}

# ./ecr-tag.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
ecr-tag-alpine:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) $(CI_PATH) alpine ${ALPINE_VERSION}

ecr-tag-ubuntu:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) $(CI_PATH) ubuntu ${UBUNTU_VERSION}

ecr-tag-codebuild:
	@echo "========================================================"
	@echo " Task      : Set Tags Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) $(CI_PATH) codebuild ${CODEBUILD_VERSION}

# ======================== #
#   PUSH CONTAINER CI/CD   #
# ======================== #
# ./dockerhub-push.sh [DOCKERHUB_IMAGE_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
.PHONY: dockerhub-push-alpine dockerhub-push-ubuntu dockerhub-push-codebuild ecr-push-alpine ecr-push-ubuntu ecr-push-codebuild
dockerhub-push-alpine:
	@echo "========================================================"
	@echo " Task      : Push Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh $(CI_PATH) alpine

dockerhub-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh $(CI_PATH) ubuntu

dockerhub-push-codebuild:
	@echo "========================================================"
	@echo " Task      : Push Image AWS CodeBuild to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh $(CI_PATH) codebuid

# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
ecr-push-alpine:
	@echo "========================================================"
	@echo " Task      : Push Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) $(CI_PATH) alpine

ecr-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) $(CI_PATH) ubuntu

ecr-push-codebuild:
	@echo "========================================================"
	@echo " Task      : Push Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) $(CI_PATH) codebuild
