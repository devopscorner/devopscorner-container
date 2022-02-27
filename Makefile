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
export PATH_DOCKER="compose/docker"
export PROJECT_NAME="container"

export CI_REGISTRY     ?= YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= cicd

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.3.0

BASE_IMAGE     = ubuntu
BASE_VERSION   = 20.04

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

push-container-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Container Image Ubuntu"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/ubuntu && ./docker-build.sh
	@cd ${PATH_DOCKER}/ubuntu && ./docker-push.sh
	@echo '- DONE -'

.PHONY: build-cicd-ubuntu push-cicd-ubuntu push-container-cicd-ubuntu
build-cicd-ubuntu:
	@echo "================================================="
	@echo " Task      : Create Container Image CI/CD Ubuntu "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh
	@echo '- DONE -'

push-cicd-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD Ubuntu"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-push.sh
	@echo '- DONE -'

push-container-cicd-ubuntu:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD Ubuntu"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-build.sh
	@cd ${PATH_DOCKER}/cicd-ubuntu && ./docker-push.sh
	@echo '- DONE -'

.PHONY: build-cicd-alpine push-cicd-alpine push-container-cicd-alpine
build-cicd-alpine:
	@echo "================================================="
	@echo " Task      : Create Container Image CI/CD Alpine "
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh
	@echo '- DONE -'

push-cicd-alpine:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD Alpine"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-push.sh
	@echo '- DONE -'

push-container-cicd-alpine:
	@echo "================================================="
	@echo " Task      : Push Container Image CI/CD Alpine"
	@echo " Date/Time : `date`"
	@echo "================================================="
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-build.sh
	@cd ${PATH_DOCKER}/cicd-alpine && ./docker-push.sh
	@echo '- DONE -'
