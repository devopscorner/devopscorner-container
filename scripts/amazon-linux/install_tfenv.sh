#!/usr/bin/env sh

# ================================================================================================
#  INSTALL TERRAFORM ENVIRONMENT (AMAZON LINUX)
# ================================================================================================
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >>~/.bash_profile
ln -sf ~/.tfenv/bin/* /usr/local/bin

mkdir -p ~/.local/bin/
. ~/.profile
ln -sf ~/.tfenv/bin/* ~/.local/bin
which tfenv
