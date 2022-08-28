# DevOpsCorner Docker Container

## Features - v2.6.1

- All features from version 2.6
- Refactoring all documentation

---

## Features - v2.6

- All features from version 2.5
- Update base image from NGINX 1.21 to NGINX 1.23
- Refactoring pipeline in Makefile using OS version

---

## Features - v2.5

- All features from version 2.4
- Remove unused build, tag, push & pull scripts
- Refactoring into single script for build, tag, push & pull for Alpine, Ubuntu & CodeBuild
- Refactoring pipeline in Makefile

---

## Features - v2.4

- Buildspec for pipeline ci/cd using Alpine, CodeBuild, Ubuntu
  - With Environment Variable
  - With Parameter Store
  - Without Repository Source

- Add new container distribution AWS CodeBuild (default version 4.0)

  ```
  FROM public.ecr.aws/codebuild/amazonlinux2-x86_64-standard:${CODEBUILD_VERSION:-4.0}
  ```

- Telnet
  - Alpine

    ```
    busybox-extras telnet [host] [port]
    ```

  - Ubuntu

    ```
    telnet [host] [port]
    ```

  - AWS Linux (CodeBuild)

    ```
    telnet [host] [port]
    ```

- Static Code Analysis for Terraform
  - [`terrascan`](https://terrascan.readthedocs.io/en/latest/readme.html)
  - [`tfsec`](https://github.com/aquasecurity/tfsec)

- Terraform Plan Scanning with [`checkov`](https://www.checkov.io/7.Scan%20Examples/Terraform%20Plan%20Scanning.html)
- Terraform Version Manager with [`tfenv`](https://github.com/tfutils/tfenv)
- Cloud Cost Estimate with [`infracost`](https://www.infracost.io/)
- [Helm3](https://v3.helm.sh/)

- Helm Plugins

   ```
   Helm Diff: https://github.com/databus23/helm-diff
   Helm S3: https://github.com/hypnoglow/helm-s3.git
   ```

- Deploy Kubernetes HelmChart with [`helmfile`](https://github.com/roboll/helmfile)
- Kubectl

## Environment Version

```
ENV ANSIBLE_VERSION=2.12.2
ENV ANSIBLE_TOWER_CLI_VERSION=3.3.4
ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.1.7
ENV TERRAGRUNT_VERSION=v0.36.1
ENV TERRASCAN_VERSION=1.14.0
ENV HELMFILE_VERSION=v0.144.0
ENV KUBECTL_VERSION=v1.24.0
```

## Available Tags

- Alpine

  ```
  devopscorner/cicd:latest
  devopscorner/cicd:1.0.3
  devopscorner/cicd:1.0.3-alpine
  devopscorner/cicd:1.0.5
  devopscorner/cicd:1.0.5-alpine
  devopscorner/cicd:alpine
  devopscorner/cicd:alpine-latest
  devopscorner/cicd:alpine-3.15
  devopscorner/cicd:alpine-3.16
  ```

- Ubuntu

  ```
  devopscorner/cicd:1.0.3-ubuntu
  devopscorner/cicd:1.0.5-ubuntu
  devopscorner/cicd:ubuntu
  devopscorner/cicd:ubuntu-latest
  devopscorner/cicd:ubuntu-20.04
  devopscorner/cicd:ubuntu-22.04
  ```

- AWS Linux (CodeBuild)

  ```
  devopscorner/cicd:codebuild
  devopscorner/cicd:codebuild-latest
  devopscorner/cicd:codebuild-2.0
  devopscorner/cicd:codebuild-3.0
  devopscorner/cicd:codebuild-4.0
  ```
