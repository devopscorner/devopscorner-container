#!/usr/bin/env sh

# ================================================================================================
#  INSTALL VAULT (AMAZON LINUX)
# ================================================================================================
export VAULT_VERSION="1.9.3"

if ! [ "${VT_VERSION}" = "" ]; then
  VAULT_VERSION=${VT_VERSION}
fi

wget -nv https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip -O /tmp/vault_${VAULT_VERSION}_linux_amd64.zip

cd /tmp
unzip -o vault_${VAULT_VERSION}_linux_amd64.zip
chmod +x /tmp/vault

mv /tmp/vault /usr/local/bin/vault
