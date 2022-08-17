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
export CI_PROJECT_NAME ?= ci/cd

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
build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh $(ARGS)
	@echo '- DONE -'

push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Container Image Ubuntu"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh $(ARGS)
	@echo '- DONE -'

build-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Build & Push Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh $(ARGS)
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh $(ARGS)
	@echo '- DONE -'

# ========================= #
#   BUILD CONTAINER CI/CD   #
# ========================= #
.PHONY: build-cicd-alpine build-cicd-ubuntu build-cicd-codebuild
build-cicd-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh $(ARGS)
	@echo '- DONE -'

build-cicd-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh $(ARGS)
	@echo '- DONE -'

build-cicd-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_DOCKER}/cicd-codebuild && ./docker-build.sh $(ARGS)
	@echo '- DONE -'

.PHONY: dockerhub-build-alpine dockerhub-build-ubuntu dockerhub-build-codebuild
dockerhub-build-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh alpine Dockerfile ${ALPINE_VERSION}

dockerhub-build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh ubuntu Dockerfile ${UBUNTU_VERSION}

dockerhub-build-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-build.sh codebuild Dockerfile ${CODEBUILD_VERSION}

.PHONY: ecr-build-alpine ecr-build-ubuntu ecr-build-codebuild
ecr-build-alpine:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) alpine Dockerfile alpine-${ALPINE_VERSION}

ecr-build-ubuntu:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) ubuntu Dockerfile ubuntu-${UBUNTU_VERSION}

ecr-build-codebuild:
	@echo "========================================================"
	@echo " Task      : Create Container CI/CD AWS CodeBuild Image "
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-build.sh $(ARGS) codebuild Dockerfile codebuild-${CODEBUILD_VERSION}

# ======================== #
#   TAGS CONTAINER CI/CD   #
# ======================== #
.PHONY: tag-dockerhub-alpine tag-dockerhub-ubuntu tag-dockerhub-codebuild tag-ecr-alpine tag-ecr-ubuntu tag-ecr-codebuild
dockerhub-tag-alpine:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh alpine ${ALPINE_VERSION}

dockerhub-tag-ubuntu:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh ubuntu ${UBUNTU_VERSION}

dockerhub-tag-codebuild:
	@echo "========================================================"
	@echo " Task      : Set Tags Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-tag.sh codebuild ${CODEBUILD_VERSION}

ecr-tag-alpine:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) alpine ${ALPINE_VERSION} $(CI_PATH)

ecr-tag-ubuntu:
	@echo "========================================================"
	@echo " Task      : Set Tags Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) ubuntu ${UBUNTU_VERSION} $(CI_PATH)

ecr-tag-codebuild:
	@echo "========================================================"
	@echo " Task      : Set Tags Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-tag.sh $(ARGS) codebuild ${CODEBUILD_VERSION} $(CI_PATH)

# ======================== #
#   PUSH CONTAINER CI/CD   #
# ======================== #
.PHONY: dockerhub-push-alpine dockerhub-push-ubuntu dockerhub-push-codebuild ecr-push-alpine ecr-push-ubuntu ecr-push-codebuild
dockerhub-push-alpine:
	@echo "========================================================"
	@echo " Task      : Push Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh alpine $(CI_PATH)

dockerhub-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh ubuntu $(CI_PATH)

dockerhub-push-codebuild:
	@echo "========================================================"
	@echo " Task      : Push Image AWS CodeBuild to DockerHub"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./dockerhub-push.sh codebuild $(CI_PATH)

ecr-push-alpine:
	@echo "========================================================"
	@echo " Task      : Push Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) alpine $(CI_PATH)

ecr-push-ubuntu:
	@echo "========================================================"
	@echo " Task      : Push Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) ubuntu $(CI_PATH)

ecr-push-codebuild:
	@echo "========================================================"
	@echo " Task      : Push Image AWS CodeBuild to ECR"
	@echo " Date/Time : `date`"
	@echo "========================================================"
	@cd ${PATH_COMPOSE} && ./ecr-push.sh $(ARGS) codebuild $(CI_PATH)
