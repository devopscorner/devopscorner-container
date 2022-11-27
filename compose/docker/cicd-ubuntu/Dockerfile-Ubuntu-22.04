# FROM ubuntu:${UBUNTU_VERSION:-22.04}
FROM nginx:${NGINX_VERSION:-1.23}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCornerId"
ENV AUTHOR="DevOpsCorner.id <support@devopscorner.id>"
ENV IMG_NAME="cicd-ubuntu"
ENV IMG_VERSION="22.04"
ENV IMG_DESC="Docker Image CI/CD"
ENV IMG_ARCH="amd64/x86_64"

ENV UBUNTU_VERSION="22.04"
ENV CICD_VERSION="1.23"

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

ENV ANSIBLE_VERSION=2.14.0
ENV ANSIBLE_TOWER_CLI_VERSION=3.3.9
ENV PACKER_VERSION=1.8.4
ENV TERRAFORM_VERSION=1.3.5
ENV TERRAGRUNT_VERSION=v0.41.0
ENV TERRASCAN_VERSION=1.17.0
ENV HELMFILE_VERSION=v0.144.0
ENV KUBECTL_VERSION=v1.25.4
ENV CHECKOV_VERSION=2.2.96

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
      telnet \
      nano \
      zip \
      unzip \
      python3-minimal \
      python3-distutils \
      python3-pip \
      python3-apt \
      iputils-ping; sync

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

# ================ #
#  Install AWSCli  #
# ================ #
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
      unzip awscliv2.zip &&\
      ./aws/Install; sync

# ========================= #
# Install Python Libraries  #
# ========================= #
RUN python3 -m pip install pip==22.0.4 &&\
      pip3 install --upgrade pip cffi &&\
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
      # checkov==${CHECKOV_VERSION} &&\
      checkov &&\
      # setup root .ssh directory
      mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown -R root. /root/.ssh

RUN chmod +x /tmp/*.sh

# cleanup cache
RUN apt-get clean &&\
      apt-get autoremove -y; sync

WORKDIR /root

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
