FROM alpine:${ALPINE_VERSION:-3.15}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="ubuntu"
ENV IMG_VERSION="3.15"
ENV IMG_DESC="Docker Image CI/CD"
ENV IMG_ARCH="amd64/x86_64"

ENV ALPINE_VERSION="3.15"
ENV CICD_VERSION="1.0.3"

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

COPY rootfs /

ENV ANSIBLE_VERSION=2.11.6
ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.1.6
ENV TERRAGRUNT_VERSION=v0.36.1

USER root
RUN apk add --no-cache \
      build-base \
      git \
      bash \
      curl \
      jq \
      libffi-dev \
      wget \
      ca-certificates \
      openssh \
      openssh-server \
      vim \
      nano \
      zip \
      unzip \
      python3 \
      python3-dev \
      py3-pip &&\
      set -ex; sync

RUN wget -O terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
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
      pip3 install --upgrade pip cffi &&\
      # install ansible
      pip3 install --no-cache-dir \
            ${ANSIBLE_CUSTOM_VERSION} \
            ansible-tower-cli==3.3.4 \
            PyYaml \
            requests \
            boto3 \
      # install awscli
            awscli &&\
      # setup root .ssh directory
      mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh

RUN chmod +x /tmp/*.sh

# cleanup cache
RUN rm -rf /var/cache/apk/* /root/.cache /tmp/*

WORKDIR /root

EXPOSE 22
