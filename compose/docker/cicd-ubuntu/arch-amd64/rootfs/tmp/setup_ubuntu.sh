#!/usr/bin/env sh

export DEBIAN_FRONTEND=noninteractive

# apt-key adv --recv-key 40976EAF437D05B5
# apt-key adv --recv-key 3B4FE6ACC0B21F32

apt -qq update
apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
  wget \
  curl \
  build-essential \
  zlib1g-dev \
  libssl-dev \
  libreadline-dev \
  libxml2 \
  libxml2-dev \
  libxslt1-dev \
  \
  software-properties-common \
  imagemagick \
  openjdk-8-jre-headless \
  libpng-dev \
  libjpeg-dev \
  libsasl2-dev \
  libmysqlclient-dev \
  phantomjs #python-software-properties \
