# DevOpsCorner OpenFortiVPN

DevOps Corner Indonesia - OpenFortiVPN Client Container Image

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![openfortivpn pulls](https://img.shields.io/docker/pulls/devopscorner/openfortivpn.svg?label=openfortivpn%20pulls&logo=fortinet)](https://hub.docker.com/r/devopscorner/openfortivpn/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/devopscorner-container/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

---

## Container `devopscorner/openfortivpn` Available Tags

### Ubuntu

| Image name | Size |
|------------|------|
| `devopscorner/openfortivpn:latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=latest) ![default-openfortivpn](https://img.shields.io/static/v1?label=latest&message=default&color=brightgreen) |
| `devopscorner/openfortivpn:22.04` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/22.04.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=22.04) ![latest-ubuntu](https://img.shields.io/static/v1?label=latest&message=ubuntu&color=orange) |
| `devopscorner/openfortivpn:22.04-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/22.04-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=22.04-latest) |
| `devopscorner/openfortivpn:22.04-1.19.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/22.04-1.19.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=22.04-1.19.0) |
| `devopscorner/openfortivpn:20.04` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/20.04.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=20.04) |
| `devopscorner/openfortivpn:20.04-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/20.04-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=20.04-latest) |
| `devopscorner/openfortivpn:20.04-1.19.0` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/openfortivpn/20.04-1.19.0.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/openfortivpn/tags?page=1&ordering=last_updated&name=20.04-1.19.0) |

## Environment

```docker
ENV VPN_HOST host
ENV VPN_PORT port
ENV VPN_ADDR host:port
ENV VPN_USER user@domain
ENV VPN_PASS secret
ENV VPN_TRUST_CERT 1234567890987654321
ENV VPN_TIMEOUT 10
```

## Linux

```bash
# Create a docker network, to be able to control addresses
docker network create --subnet=172.20.0.0/16 openfortivpn

# Start the priviledged docker container with a static ip
docker run -it --rm \
  --privileged \
  --net openfortivpn --ip 172.20.0.2 \
  -e VPN_HOST=host \
  -e VPN_PORT=port \
  -e VPN_ADDR=host:port \
  -e VPN_USER=user@domain \
  -e VPN_PASS=secret \
  -e VPN_TRUST_CERT=1234567890987654321
  devopscorner/openfortivpn

# Add route for you remote subnet (ex. 10.201.0.0/16)
ip route add 10.201.0.0/16 via 172.20.0.2

# Access remote host from the subnet
ssh 10.201.8.1
```

## OSX

```bash
# Create a docker-machine and configure shell to use it
docker-machine create openfortivpn --driver virtualbox
eval $(docker-machine env openfortivpn)

# Start the priviledged docker container on its host network
docker run -it --rm \
  --privileged --net host \
  -e VPN_HOST=host \
  -e VPN_PORT=port \
  -e VPN_ADDR=host:port \
  -e VPN_USER=user@domain \
  -e VPN_PASS=secret \
  -e VPN_TRUST_CERT=1234567890987654321
  devopscorner/openfortivpn

# Add route for you remote subnet (ex. 10.201.0.0/16)
sudo route add -net 10.201.0.0/16 $(docker-machine ip openfortivpn)

# Access remote host from the subnet
ssh 10.201.8.1
```

## Misc

If you don't want to use a docker network, you can find out the container ip once it is started with:

```bash
# Find out the container IP
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container>
```
