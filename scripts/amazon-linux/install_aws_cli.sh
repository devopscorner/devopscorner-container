#!/usr/bin/env sh

# ================================================================================================
#  INSTALL AWS CLI (AMAZON LINUX)
# ================================================================================================
curl -O https://bootstrap.pypa.io/get-pip.py

### Python 3.x ###
python3 get-pip.py --user
pip3 install awscli --upgrade --user

### Python 2.7.x ###
# python2 get-pip.py --user
# pip install awscli --upgrade --user
