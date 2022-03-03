#!/usr/bin/env sh

# ================================================================================================
#  INSTALL NGINX (Ubuntu LINUX)
# ================================================================================================
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  git \
  bash \
  nginx \
  software-properties-common \
  openssh-server \
  openssh-client \
  apt-transport-https

service nginx reload
service nginx restart