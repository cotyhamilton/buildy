# buildy

A container to build container images from git repos.

It uses https://github.com/genuinetools/img as the base image for working with images inside a container.

This project is similar to kaniko, but buildy works with Azure Repos while kaniko does not.

## How to use

### Docker

```
docker run -it --rm \
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

Example pod

```
apiVersion: v1
kind: Pod
metadata:
  name: buildy
  namespace: ci
spec:
  containers:
  - name: buildy
    image: cotyhamilton/buildy
    args:
    - "--git-url=https://github.com/cotyhamilton/buildy.git"
    - "--git-source-branch=main"
    - "--namespace=cotyhamilton"
    - "--image-name=buildy"
    - "--tags=latest"
    volumeMounts:
      - name: regcred
        mountPath: /home/user/.docker
    resources:
      limits:
        cpu: "1"
        memory: 512M
  restartPolicy: Never
  volumes:
    - name: regcred
      secret:
        secretName: dockerconfig
        items:
          - key: .dockerconfigjson
            path: config.json
```

Refer to [img docs](https://github.com/genuinetools/img#running-with-kubernetes) for security

### Options

Run the container to see all options

```
docker run -it --rm cotyhamilton/buildy
```
