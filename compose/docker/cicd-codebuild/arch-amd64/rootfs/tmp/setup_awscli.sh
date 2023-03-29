#!/usr/bin/env sh

yum amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user

chkconfig docker on
yum install -y git