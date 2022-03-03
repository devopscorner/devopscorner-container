#!/usr/bin/env sh

# ================================================================================================
#  INSTALL PACKER (AMAZON LINUX)
# ================================================================================================
export PACKER_VERSION="1.7.10"

if ! [ "${PACK_VERSION}" = "" ]; then
  PACKER_VERSION=${PACK_VERSION}
fi

wget -q -nv https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /usr/local/bin/packer.zip
rm -f /usr/local/bin/packer
cd /usr/local/bin
unzip /usr/local/bin/packer.zip
rm -f /usr/local/bin/packer.zip

chmod +x /usr/local/bin/packer
