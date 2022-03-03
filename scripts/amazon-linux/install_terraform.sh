#!/usr/bin/env sh

# ================================================================================================
#  INSTALL TERRAFORM (AMAZON LINUX)
# ================================================================================================
export TERRAFORM_VERSION="1.1.6"

if ! [ "${TF_VERSION}" = "" ]; then
  TERRAFORM_VERSION=${TF_VERSION}
fi

wget -nv https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

cd /tmp
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
chmod +x /tmp/terraform

mv /tmp/terraform /usr/local/bin/terraform
