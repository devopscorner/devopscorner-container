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

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

BASE_IMAGE     = ubuntu
BASE_VERSION   = 20.04

# ==================== #
#   CONTAINER UBUNTU   #
# ==================== #
.PHONY: run stop remove build push push-container
run:
	@echo "================================================="
	@echo " Task      : Docker Container "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@./run-docker.sh
	@echo '- DONE -'

stop:
	@echo "================================================="
	@echo " Task      : Stopping Docker Container "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@docker-compose -f ${PATH_COMPOSE}/app-compose.yml stop
	@echo '- DONE -'

.PHONY: build-ubuntu push-ubuntu push-container-ubuntu
build-ubuntu:
	@echo "================================================="
	@echo " Task      : Create Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh
	@echo '- DONE -'

push-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Container Image Ubuntu"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh
	@echo '- DONE -'

build-push-ubuntu:
	@echo "================================================="
	@echo " Task      : Build & Push Container Image Ubuntu "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh
	@echo '- DONE -'

# ========================= #
#   BUILD CONTAINER CI/CD   #
# ========================= #
.PHONY: build-cicd-alpine build-cicd-ubuntu
build-cicd-alpine:
	@echo "================================================="
	@echo " Task      : Create Container CI/CD Alpine Image "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh $(ARGS)
	@cd ${PATH_COMPOSE} && docker-compose -f app-compose-cicd-alpine.yml up -d
	@echo '- DONE -'

build-cicd-ubuntu:
	@echo "================================================="
	@echo " Task      : Create Container CI/CD Ubuntu Image "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh $(ARGS)
	@cd ${PATH_COMPOSE} && docker-compose -f app-compose-cicd-ubuntu.yml up -d
	@echo '- DONE -'

# ======================== #
#   TAGS CONTAINER CI/CD   #
# ======================== #
.PHONY: tag-dockerhub-alpine tag-dockerhub-ubuntu tag-ecr-alpine tag-ecr-ubuntu
dockerhub-tag-alpine:
	@echo "================================================="
	@echo " Task      : Set Tags Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./dockerhub-tag-alpine.sh
	@echo '- DONE -'

dockerhub-tag-ubuntu:
	@echo "================================================="
	@echo " Task      : Set Tags Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./dockerhub-tag-ubuntu.sh
	@echo '- DONE -'

ecr-tag-alpine:
	@echo "================================================="
	@echo " Task      : Set Tags Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./ecr-tag-alpine.sh $(ARGS)
	@echo '- DONE -'

ecr-tag-ubuntu:
	@echo "================================================="
	@echo " Task      : Set Tags Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./ecr-tag-ubuntu.sh $(ARGS)
	@echo '- DONE -'

# ======================== #
#   PUSH CONTAINER CI/CD   #
# ======================== #
.PHONY: dockerhub-push-alpine dockerhub-push-ubuntu ecr-push-alpine ecr-push-ubuntu
dockerhub-push-alpine:
	@echo "================================================="
	@echo " Task      : Push Image Alpine to DockerHub"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./dockerhub-push-alpine.sh
	@echo '- DONE -'

dockerhub-push-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Image Ubuntu to DockerHub"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./dockerhub-push-ubuntu.sh
	@echo '- DONE -'

ecr-push-alpine:
	@echo "================================================="
	@echo " Task      : Push Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./ecr-push-alpine.sh $(ARGS)
	@echo '- DONE -'

ecr-push-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Image Ubuntu to ECR"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_COMPOSE} && ./ecr-push-ubuntu.sh $(ARGS)
	@echo '- DONE -'