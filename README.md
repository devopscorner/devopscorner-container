# DevOpsCorner Docker Container

DevOpsCorner.id Container Images

![all contributors](https://img.shields.io/github/contributors/devopscorner/devopscorner-container)
![tags](https://img.shields.io/github/v/tag/devopscorner/devopscorner-container?sort=semver)
[![cicd pulls](https://img.shields.io/docker/pulls/devopscorner/cicd.svg?label=cicd%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/cicd/)
[![openfortivpn pulls](https://img.shields.io/docker/pulls/devopscorner/openfortivpn.svg?label=openfortivpn%20pulls&logo=fortinet)](https://hub.docker.com/r/devopscorner/openfortivpn/)
![download all](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/devopscorner-container/2.8.0/total)
![view](https://views.whatilearened.today/views/github/devopscorner/devopscorner-container.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/devopscorner-container/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/devopscorner-container)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/devopscorner-container)
![forks](https://img.shields.io/github/forks/devopscorner/devopscorner-container)
![stars](https://img.shields.io/github/stars/devopscorner/devopscorner-container)
[![license](https://img.shields.io/github/license/devopscorner/devopscorner-container)](https://img.shields.io/github/license/devopscorner/devopscorner-container)

---

## Available Tags

- Container `devopscorner/aws-cli` [Tags](docs/README-AWS-Cli.md)
- Container `devopscorner/cicd` [Tags](docs/README-CICD.md)
- Container `devopscorner/openfortivpn` [Tags](docs/README-OpenFortiVPN.md)
- Container `devopscorner/phpfpm` [Tags](docs/README-PHPFpm.md)

---

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)

## Documentation

- Index Documentation, go to [this](docs/README.md) link
- Build, Tag & Push container cicd image to **DockerHub**, go to [this](docs/container-cicd-dockerhub.md) link
- Build, Tag & Push container cicd image to **Amazon ECR (Elastic Container Registry)**, go to [this](docs/container-cicd-ecr.md) link
- Reproduce DEMO, detail [here](docs/DEMO.md)

## Security Check

Make sure that you didn't push sensitive information in this repository

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET_KEY)
- [ ] AWS Account ID
- [ ] AWS Resources ARN
- [ ] Username & Password
- [ ] Private (id_rsa) & Public Key (id_rsa.pub)
- [ ] DNS Zone ID
- [ ] APP & API Key

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
