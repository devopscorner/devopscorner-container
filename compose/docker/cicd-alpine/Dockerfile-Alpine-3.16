# FROM alpine:${ALPINE_VERSION:-3.16}
FROM nginx:${NGINX_VERSION:-1.23-alpine}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="cicd-alpine"
ENV IMG_VERSION="3.16"
ENV IMG_DESC="Docker Image CI/CD"
ENV IMG_ARCH="amd64/x86_64"

ENV ALPINE_VERSION="3.16"
ENV CICD_VERSION="1.0.5"

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

ENV ANSIBLE_VERSION=2.12.2
ENV ANSIBLE_TOWER_CLI_VERSION=3.3.4
ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.1.7
ENV TERRAGRUNT_VERSION=v0.36.1
ENV TERRASCAN_VERSION=1.14.0
ENV HELMFILE_VERSION=v0.144.0
ENV KUBECTL_VERSION=v1.24.0

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
      busybox-extras \
      nano \
      zip \
      unzip \
      python3 \
      python3-dev \
      py3-pip &&\
      set -ex; sync

# =================== #
#  Install Terraform  #
# =================== #
RUN wget -O terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
      https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
      unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin &&\
      rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip; sync &&\
      # ==================== #
      #  Install Terragrunt  #
      # ==================== #
      wget -O /usr/local/bin/terragrunt \
      https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 &&\
      chmod +x /usr/local/bin/terragrunt; sync &&\
      # ================ #
      #  Install Packer  #
      # ================ #
      wget -O packer_${PACKER_VERSION}_linux_amd64.zip \
      https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip &&\
      unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin &&\
      rm -f packer_${PACKER_VERSION}_linux_amd64.zip; sync &&\
      # =================== #
      #  Install Terrascan  #
      # =================== #
      wget -O terrascan.tar.gz \
      https://github.com/accurics/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz &&\
      tar -zxf terrascan.tar.gz -C /usr/local/bin &&\
      chmod +x /usr/local/bin/terrascan &&\
      rm terrascan.tar.gz; sync &&\
      # =============== #
      #  Install TFSec  #
      # =============== #
      curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash; sync &&\
      # =================== #
      #  Install Infracost  #
      # =================== #
      curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | bash; sync

# =============== #
#  Install TFenv  #
# =============== #
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv &&\
      echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile &&\
      ln -sf ~/.tfenv/bin/* /usr/local/bin &&\
      mkdir -p ~/.local/bin/ &&\
      ln -sf ~/.tfenv/bin/* ~/.local/bin; sync

# ============== #
#  Install Helm  #
# ============== #
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 &&\
      chmod 700 get_helm.sh &&\
      ./get_helm.sh &&\
      helm version; sync

# ===================== #
#  Install Helm Plugins #
# ===================== #
RUN helm plugin install https://github.com/databus23/helm-diff &&\
      helm plugin install https://github.com/hypnoglow/helm-s3.git &&\
      helm repo add stable https://charts.helm.sh/stable &&\
      helm repo update; sync

# ================== #
#  Install Helmfile  #
# ================== #
RUN wget -O /usr/local/bin/helmfile \
      https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 &&\
      chmod +x /usr/local/bin/helmfile &&\
      helmfile --version; sync

# ================= #
#  Install Kubectl  #
# ================= #
RUN wget -O /usr/local/bin/kubectl \
      https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl &&\
      chmod +x /usr/local/bin/kubectl; sync

# ========================= #
# Install Python Libraries  #
# ========================= #
RUN python3 -m pip install pip==22.0.4 &&\
      pip3 install --upgrade pip cffi awscli &&\
      # ================= #
      #  Install Ansible  #
      # ================= #
      pip3 install --no-cache-dir \
      ansible-core==${ANSIBLE_VERSION} \
      ansible-tower-cli==${ANSIBLE_TOWER_CLI_VERSION} \
      PyYaml \
      Jinja2 \
      httplib2 \
      six \
      requests \
      boto3 \
      # ================= #
      #  Install Checkov  #
      # ================= #
      checkov &&\
      # setup root .ssh directory
      mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh

RUN chmod +x /tmp/*.sh

# cleanup cache
RUN rm -rf /var/cache/apk/* /root/.cache /tmp/*

WORKDIR /root

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
