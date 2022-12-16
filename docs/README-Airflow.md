# DevOpsCorner Airflow Container

DevOps Corner Indonesia - Airflow Container Image (`Airflow 2.5.0` & `Python 3.10.8`)

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![aiflow pulls](https://img.shields.io/docker/pulls/devopscorner/airflow.svg?label=airflow%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/airflow/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/devopscorner-container/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

---

## Available Tags

### Ubuntu

| Image name | Size |
|------------|------|
| `devopscorner/airflow:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/airflow/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/airflow/tags?page=1&ordering=last_updated&name=latest) ![default-airflow](https://img.shields.io/static/v1?label=latest&message=default&color=brightgreen) ![latest-airflow](https://img.shields.io/static/v1?label=latest&message=ubuntu&color=orange) |
| `devopscorner/airflow:2.5.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/airflow/2.5.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/airflow/tags?page=1&ordering=last_updated&name=2.5.0) |
| `devopscorner/airflow:python3.10.8-2.5.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/airflow/python3.10.8-2.5.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/airflow/tags?page=1&ordering=last_updated&name=python3.10.8-2.5.0) |
| `devopscorner/airflow:ubuntu-2.5.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/airflow/ubuntu-2.5.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/airflow/tags?page=1&ordering=last_updated&name=ubuntu-2.5.0) |
| `devopscorner/airflow:ubuntu` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/airflow/ubuntu.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/airflow/tags?page=1&ordering=last_updated&name=ubuntu) |

---

## AWS CLI Environment Variables

### References
 - [CLI Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Linux
```
$ export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID
$ export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY
$ export AWS_DEFAULT_REGION=ap-southeast-3
```

### Windows
```
## To set for all sessions
C:\> setx AWS_ACCESS_KEY_ID YOUR_AWS_ACCESS_KEY_ID
C:\> setx AWS_SECRET_ACCESS_KEY YOUR_AWS_SECRET_ACCESS_KEY
C:\> setx AWS_DEFAULT_REGION ap-southeast-3

## To set for current session only
C:\> set AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID
C:\> set AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY
C:\> set AWS_DEFAULT_REGION=ap-southeast-3
```

### PowerShell

```
PS C:\> $Env:AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
PS C:\> $Env:AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
PS C:\> $Env:AWS_DEFAULT_REGION="ap-southeast-3"
```

## Environment

```docker
ENV AWS_CLI_VERSION=2.9.1
ENV AIRFLOW_VERSION=2.5.0
ENV VERIFY_CHECKSUM=false

ENV AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
ENV AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
```

## Python Libraries

```
pandas==1.5.2
boto3==1.26.22
plotly==5.11.0
paramiko==2.12.0
psycopg2-binary
scikit-learn==0.24.1
cryptography==36.0.2
```



## Dockerfile

```docker
FROM apache/airflow:2.5.0-python3.10

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="airflow"
ENV IMG_VERSION="2.5.0"
ENV IMG_DESC="Docker Image Airflow 2.5.0 with Python-3.10"
ENV IMG_ARCH="amd64/x86_64"

ENV AWS_CLI_VERSION=2.9.1
ENV AIRFLOW_VERSION=2.5.0
ENV VERIFY_CHECKSUM=false

LABEL maintainer="$AUTHOR" \
    architecture="$IMG_ARCH" \
    airflow-version="$AIRFLOW_VERSION" \
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

COPY rootfs /

ENV DEBIAN_FRONTEND noninteractive

USER root
RUN apt-get -o APT::Sandbox::User=root update; sync
RUN apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    wget; sync

RUN apt-get install -y \
    bash \
    jq \
    apt-transport-https \
    ca-certificates \
    openssl \
    openssh-server \
    openssh-client \
    net-tools \
    vim-tiny \
    telnet \
    nano \
    libffi-dev \
    bzip2 \
    python3-minimal \
    python3-distutils \
    python3-pip \
    python3-apt \
    gcc \
    iputils-ping; sync

# =================== #
#  Install AWSCli v2  #
# =================== #
RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o awscliv2.zip &&\
    unzip awscliv2.zip; sync &&\
    ./aws/install --bin-dir /usr/local/bin/; sync
# COPY --from=devopscorner/aws-cli:latest /usr/local/aws-cli/ /usr/local/aws-cli/
# COPY --from=devopscorner/aws-cli:latest /usr/local/bin/ /usr/local/bin/

# ========================= #
# Install Python Libraries  #
# ========================= #
RUN python3 -m pip install pip &&\
    pip3 install --upgrade pip==22.3.1 cffi &&\
    pip3 install --no-cache-dir \
    PyYaml \
    Jinja2 \
    httplib2 \
    six \
    requests \
    ivy-core &&\
    # setup root .ssh directory
    mkdir -p /root/.ssh &&\
    chmod 0700 /root/.ssh &&\
    chown -R root. /root/.ssh; sync

USER airflow

ENV AWS_ACCESS_KEY_ID=$SET_AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$SET_AWS_SECRET_ACCESS_KEY

RUN pip install -r /tmp/airflow/requirements.txt
```

## Requirement Libraries (`requirements.txt`)

```
pip install -r /tmp/airflow/requirements.txt
---
pandas==1.5.2
boto3==1.26.22
plotly==5.11.0
paramiko==2.12.0
psycopg2-binary
scikit-learn==0.24.1
cryptography==36.0.2
```