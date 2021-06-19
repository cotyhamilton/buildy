# buildy

A container to build container images from git repos.

It uses https://github.com/genuinetools/img as the base image for working with images inside a container.

This project is similar to kaniko, but buildy works with Azure repos while kaniko does not.

## How to use

### Docker

```
docker run -it \
    --security-opt seccomp=unconfined \
    --security-opt apparmor=unconfined \
    cotyhamilton/buildy \
    --git-url=<git repository url> \
    --git-source-branch=<git branch name> \
    --registry=<registry url> \ # do not use arg if pushing to dockerhub
    --namespace=<registry namespace> \
    --image-name=<name of image> \
    --tags=<comma delimited list of tags ex: "latest, 1.0.0"> \
    --registry-user=<registry user id> \
    --registry-password=<registry user password> \
```

Instead of passing credentials as args, you may mount a docker config to `/home/user/.docker/config.json`

### Kubernetes

All options

```
Usage: buildy [OPTIONS]

OPTIONS:
  -h, --help                            Prints help information
      --git-url                         Url for git repo
      --git-personal-access-token       Optional PAT for authentication with private repo
      --git-oauth-token                 Optional oauth token for authentication with private repo
      --git-source-branch               Optional git branch to build from (one source is required)
      --git-source-commit               Optional git commit id to build from (one source is required)
      --docker-context                  Optional path to build context relative to repo root
      --dockerfile                      Optional path to dockerfile relative to repo root
      --registry                        Optional url of container registry (do not use for dockerhub)
      --namespace                       Registry namespace
      --image-name                      Registry repo
      --tags                            Comma delimited list of tags for push: --tags="1.0.0,latest"
      --registry-user                   Optional registry username (alternatively mount docker config.json)
      --registry-password               Optional registry password (alternatively mount docker config.json)
      --build-args                      Args passsed to build (refer to img docs)
      --push-args                       Args passed to push (refer to img docs)
```
