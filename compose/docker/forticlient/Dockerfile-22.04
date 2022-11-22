FROM ubuntu:${UBUNTU_VERSION:-22.04}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="forticlient"
ENV IMG_VERSION="22.04"
ENV IMG_DESC="Docker Image Forticlient from Ubuntu 22.04"
ENV IMG_ARCH="amd64/x86_64"

ENV UBUNTU_VERSION="22.04"
ENV FORTICLIENT_VERSION="4.4"

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      ubuntu-version="$UBUNTU_VERSION" \
      forticlient-version="$FORTICLIENT_VERSION" \
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

ENV VPNADDR host:port
ENV VPNUSER user@domain
ENV VPNPASS secret
ENV VPNTIMEOUT 10

USER root
RUN apt -o APT::Sandbox::User=root update; sync
RUN apt-get update; sync
RUN apt-get install -y -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
      git \
      bash \
      curl \
      wget \
      apt-transport-https \
      ca-certificates \
      openssh-server \
      openssh-client \
      net-tools \
      expect \
      iproute2 \
      ipppd \
      iptables \
      iputils-ping; sync

RUN chmod +x /tmp/*.sh

RUN apt-get clean -q && apt-get autoremove --purge; sync
RUN rm -rf /var/lib/apt/lists/*; sync

WORKDIR /root

# Install fortivpn client unofficial .deb
RUN wget 'https://raw.githubusercontent.com/devopscorner/devopscorner-container/master/compose/docker/forticlient/rootfs/tmp/forticlient-sslvpn_4.4.2329-1_amd64.deb' -O forticlient-sslvpn_amd64.deb
RUN dpkg -x forticlient-sslvpn_amd64.deb /usr/share/forticlient && rm forticlient-sslvpn_amd64.deb

# Run setup
RUN /usr/share/forticlient/opt/forticlient-sslvpn/64bit/helper/setup.linux.sh 2

# Copy runfiles
COPY rootfs/tmp/forticlient /usr/bin/forticlient
COPY rootfs/tmp/start.sh /start.sh

EXPOSE 22
