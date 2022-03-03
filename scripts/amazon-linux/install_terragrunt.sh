#!/usr/bin/env sh

# ================================================================================================
#  INSTALL TERRAGRUNT (AMAZON LINUX)
# ================================================================================================
export TERRAGRUNT_VERSION="0.36.1"

if ! [ "${TG_VERSION}" = "" ]; then
  TERRAGRUNT_VERSION=${TG_VERSION}
fi

wget -q -nv https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt

chmod +x /usr/local/bin/terragrunt
