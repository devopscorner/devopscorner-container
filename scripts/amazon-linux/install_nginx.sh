#!/usr/bin/env sh

# ================================================================================================
#  INSTALL NGINX (AMAZON LINUX)
# ================================================================================================
amazon-linux-extras list | grep nginx
sudo amazon-linux-extras enable epel
sudo yum install -y epel-release
sudo yum install -i nginx

sudo service nginx reload
sudo service nginx restart