# DevOpsCorner AWS-Cli v2

DevOps Corner Indonesia - AWS Cli v2 Container Image (`Alpine 3.16` & `Python 3.10.8`)

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![aws-cli pulls](https://img.shields.io/docker/pulls/devopscorner/aws-cli.svg?label=aws-cli%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/aws-cli/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/devopscorner-container/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

---

## Container `devopscorner/aws-cli` Available Tags

### Alpine

| Image name | Size |
|------------|------|
| `devopscorner/aws-cli:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/aws-cli/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/aws-cli/tags?page=1&ordering=last_updated&name=latest) ![default-aws-cli](https://img.shields.io/static/v1?label=latest&message=default&color=brightgreen) ![latest-aws-cli](https://img.shields.io/static/v1?label=latest&message=ubuntu&color=orange) |
| `devopscorner/aws-cli:2.9.1` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/aws-cli/2.9.1.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/aws-cli/tags?page=1&ordering=last_updated&name=2.9.1) |
| `devopscorner/aws-cli:python3.10.8-2.9.1` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/aws-cli/python3.10.8-2.9.1.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/aws-cli/tags?page=1&ordering=last_updated&name=python3.10.8-2.9.1) |

---

## Environment

```docker
ARG ALPINE_VERSION=3.16
ARG AWS_CLI_VERSION=2.9.1
ENV CICD_VERSION="1.23"
```

## Dockerfile

```docker
ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL
ARG ALPINE_VERSION=3.16

### Builder ###
FROM python:3.10.5-alpine${ALPINE_VERSION} as builder

ARG AWS_CLI_VERSION=2.9.1
RUN apk add --no-cache git unzip groff build-base libffi-dev cmake
RUN git clone --single-branch --depth 1 -b ${AWS_CLI_VERSION} https://github.com/aws/aws-cli.git

WORKDIR aws-cli
RUN python -m venv venv
RUN . venv/bin/activate
RUN scripts/installers/make-exe
RUN unzip -q dist/awscli-exe.zip
RUN aws/install --bin-dir /aws-cli-bin
RUN /aws-cli-bin/aws --version

# reduce image size: remove autocomplete and examples
RUN rm -rf \
    /usr/local/aws-cli/v2/current/dist/aws_completer \
    /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
    /usr/local/aws-cli/v2/current/dist/awscli/examples
RUN find /usr/local/aws-cli/v2/current/dist/awscli/data -name completions-1*.json -delete
RUN find /usr/local/aws-cli/v2/current/dist/awscli/botocore/data -name examples-1.json -delete

### Binary ###
FROM alpine:${ALPINE_VERSION}

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="awscli-alpine"
ENV IMG_VERSION="3.16"
ENV IMG_DESC="Docker Image AWS CLI Alpine"
ENV IMG_ARCH="amd64/x86_64"

ENV CICD_VERSION="1.23"

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      alpine-version="$ALPINE_VERSION" \
      cicd-version="$CICD_VERSION" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.name="$IMG_NAME" \
      org.label-schema.description="$IMG_DESC" \
      org.label-schema.vcs-ref="$GIT_COMMIT" \
      org.label-schema.vcs-url="$GIT_URL" \
      org.label-schema.vendor="$VENDOR" \
      org.label-schema.version="$BUILD_VERSION" \
      org.label-schema.schema-version="$IMG_VERSION" \
      org.opencontainers.image.authors="$AUTHOR" \
      org.opencontainers.image.description="$IMG_DESC" \
      org.opencontainers.image.vendor="$VENDOR" \
      org.opencontainers.image.version="$IMG_VERSION" \
      org.opencontainers.image.revision="$GIT_COMMIT" \
      org.opencontainers.image.created="$BUILD_DATE" \
      fr.hbis.docker.base.build-date="$BUILD_DATE" \
      fr.hbis.docker.base.name="$IMG_NAME" \
      fr.hbis.docker.base.vendor="$VENDOR" \
      fr.hbis.docker.base.version="$BUILD_VERSION"

COPY --from=builder /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=builder /aws-cli-bin/ /usr/local/bin/
```
