FROM devopscorner/cicd:${CICD_VERSION:-1.23-alpine}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="sftp-alpine"
ENV IMG_VERSION="3.16"
ENV IMG_DESC="Docker Image CI/CD"
ENV IMG_ARCH="amd64/x86_64"

ENV ALPINE_VERSION="3.16"
ENV CICD_VERSION="1.23"

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      alpine-version="$ALPINE_VERSION" \
      sftp-version="$CICD_VERSION" \
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

# Steps done in one RUN layer:
# - Install packages
# - OpenSSH needs /var/run/sshd to run
# - Remove generic host keys, entrypoint generates unique keys
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
      apk add --no-cache bash shadow@community openssh-server-pam openssh-sftp-server && \
      ln -sf /usr/sbin/sshd.pam /usr/sbin/sshd && \
      mkdir -p /var/run/sshd && \
      rm -f /etc/ssh/ssh_host_*key*

COPY rootfs/tmp/sshd_config /etc/ssh/sshd_config
COPY rootfs/tmp/create-sftp-user /usr/local/bin/
COPY rootfs/tmp/entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]