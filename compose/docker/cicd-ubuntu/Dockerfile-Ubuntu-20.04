FROM ubuntu:${UBUNTU_VERSION:-20.04}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="cicd-ubuntu"
ENV IMG_VERSION="20.04"
ENV IMG_DESC="Docker Image CI/CD"
ENV IMG_ARCH="amd64/x86_64"

ENV UBUNTU_VERSION="20.04"
ENV CICD_VERSION="1.0.34"

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      ubuntu-version="$UBUNTU_VERSION" \
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

COPY rootfs /

ENV DEBIAN_FRONTEND noninteractive

ENV ANSIBLE_VERSION=2.12.2
ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.1.6
ENV TERRAGRUNT_VERSION=v0.36.1

USER root
RUN apt -o APT::Sandbox::User=root update; sync
RUN apt-get update; sync
RUN apt-get install -y \
      git \
      bash \
      curl \
      wget \
      jq \
      apt-transport-https \
      ca-certificates \
      openssh-server \
      openssh-client \
      net-tools \
      vim-tiny \
      nano \
      zip \
      unzip \
      python3-minimal \
      python3-distutils \
      python3-pip \
      python3-apt \
      iputils-ping; sync

## install awscli
RUN apt-get install -y \
      awscli &&\
      # install terraform
      wget -O terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
      https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
      unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin &&\
      rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
      # install terragrunt
      wget -O /usr/local/bin/terragrunt \
      https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 &&\
      chmod +x /usr/local/bin/terragrunt &&\
      # install packer
      wget -O packer_${PACKER_VERSION}_linux_amd64.zip \
      https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip &&\
      unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin &&\
      rm -f packer_${PACKER_VERSION}_linux_amd64.zip; sync

RUN python3 -m pip install pip==21.3.1 &&\
      pip3 install --upgrade pip cffi awscli &&\
      # install ansible
      pip3 install ansible-core==${ANSIBLE_VERSION} \
      ansible-tower-cli==3.3.4 \
      PyYaml \
      Jinja2 \
      httplib2 \
      six \
      requests \
      boto3 &&\
      # setup root .ssh directory
      mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh

RUN chmod +x /tmp/*.sh

# cleanup cache
RUN apt-get clean &&\
      apt-get autoremove -y; sync

WORKDIR /root

EXPOSE 22
