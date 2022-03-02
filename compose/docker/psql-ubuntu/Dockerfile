FROM postgres:${POSTGRES_VERSION:-14.1}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="psql"
ENV IMG_VERSION="14.1"
ENV IMG_DESC="PostgreSQL Docker Image"
ENV IMG_ARCH="amd64/x86_64"

ENV POSTGRES_VERSION="14.1"

LABEL maintainer="$AUTHOR" \
      architecture="$IMG_ARCH" \
      postgres-version="$POSTGRES_VERSION" \
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

ENV DEBIAN_FRONTEND=noninteractive

ENV POSTGRES_USER=${POSTGRES_USER:-postgres}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
# ENV PGDATA=${PGDATA:-/var/lib/postgresql/pgdata}

RUN apt -o APT::Sandbox::User=root update; sync
RUN apt-get update; sync
RUN apt-get install -y \
      curl

COPY config/postgresql.conf /var/lib/postgresql
COPY rootfs /

RUN apt-get clean; sync

VOLUME /var/lib/postgresql/data

EXPOSE 5432

CMD ["postgres"]
