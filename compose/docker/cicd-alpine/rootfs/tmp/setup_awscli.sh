#!/usr/bin/env sh

apk add --no-cache \
      build-base \
      git \
      python3 \
      python3-dev \
      py3-pip

python3 -m pip install pip==21.3.1 &&
      pip3 install --upgrade pip==22.3.1 cffi awscli &&
      pip3 install --no-cache-dir \
            PyYaml \
            requests \
            boto3

# install awscli
awscli

# setup root .ssh directory
mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh
