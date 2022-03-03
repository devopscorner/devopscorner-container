#!/usr/bin/env sh

# ================================================================================================
#  INSTALL KUBECTX (AMAZON LINUX)
# ================================================================================================
export KUBECTX_PATH="$GOPATH/src/github.com/kubectx"

git clone https://github.com/ahmetb/kubectx $KUBECTX_PATH

ln -snf $KUBECTX_PATH/kubectx /usr/local/bin/kubectx
ln -snf $KUBECTX_PATH/kubectx /usr/local/bin/kx

ln -snf $KUBECTX_PATH/kubens /usr/local/bin/kubens
ln -snf $KUBECTX_PATH/kubens /usr/local/bin/ks
