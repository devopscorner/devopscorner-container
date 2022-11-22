# DevOpsCorner Docker Container

Docker Container Images Repository for DevOpsCorner.id

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![docker pulls](https://img.shields.io/docker/pulls/devopscorner/cicd.svg)](https://hub.docker.com/r/devopscorner/cicd/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://github.com/devopscorner/devopscorner-container/blob/main/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

---

## Container `devopscorner/forticlient` Available Tags

### Ubuntu

| Image name | Size |
|------------|------|
| `devopscorner/forticlient:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=latest) |
| `devopscorner/forticlient:22.04` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/22.04.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=22.04) |
| `devopscorner/forticlient:22.04-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/22.04-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=22.04-latest) |
| `devopscorner/forticlient:22.04-4.4` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/22.04-4.4.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=22.04-4.4) |
| `devopscorner/forticlient:20.04` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/20.04.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=20.04) |
| `devopscorner/forticlient:20.04-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/20.04-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=20.04-latest) |
| `devopscorner/forticlient:20.04-4.4` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/forticlient/20.04-4.4.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/forticlient/tags?page=1&ordering=last_updated&name=20.04-4.4) |

## Environment

```docker
ENV VPNADDR host:port
ENV VPNUSER user@domain
ENV VPNPASS secret
ENV VPNTIMEOUT 10
```

## Linux

```bash
# Create a docker network, to be able to control addresses
docker network create --subnet=172.20.0.0/16 fortinet

# Start the priviledged docker container with a static ip
docker run -it --rm \
  --privileged \
  --net fortinet --ip 172.20.0.2 \
  -e VPNADDR=host:port \
  -e VPNUSER=me@domain \
  -e VPNPASS=secret \
  devopscorner/forticlient

# Add route for you remote subnet (ex. 10.201.0.0/16)
ip route add 10.201.0.0/16 via 172.20.0.2

# Access remote host from the subnet
ssh 10.201.8.1
```

## OSX

```bash
# Create a docker-machine and configure shell to use it
docker-machine create fortinet --driver virtualbox
eval $(docker-machine env fortinet)

# Start the priviledged docker container on its host network
docker run -it --rm \
  --privileged --net host \
  -e VPNADDR=host:port \
  -e VPNUSER=me@domain \
  -e VPNPASS=secret \
  devopscorner/forticlient

# Add route for you remote subnet (ex. 10.201.0.0/16)
sudo route add -net 10.201.0.0/16 $(docker-machine ip fortinet)

# Access remote host from the subnet
ssh 10.201.8.1
```

## Misc

If you don't want to use a docker network, you can find out the container ip once it is started with:

```bash
# Find out the container IP
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container>
```
