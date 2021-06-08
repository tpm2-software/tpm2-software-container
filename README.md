# tpm2-software-container

This repository contains metadata and scripts used to generate the container
images used for continuous integration (CI) by the various tpm2-software
projects.

## Local build

To build the container image locally invoke [Docker](https://www.docker.com/) or
[Podman](https://podman.io/) with the build command generated using `make` from
within the `tpm2-software-container` directory. For example:

```sh
make

# Build Ubuntu 20.04 image using Docker
docker build -f ./ubuntu-20.04.docker

# Build Fedora 32 image using Podman, squashing all intermediate layers together
podman build --squash -f ./fedora-32.docker
```

The final output of the build will be an IMAGE ID which can be used to run the container image, for example:

```sh
docker run -it <IMAGE ID> /bin/bash
```

or to run the [tpm2-tools](https://github.com/tpm2-software/tpm2-tools) CI sequence locally:

```sh
docker run --rm --env-file /path/to/tpm2-tools/.ci/docker.env -v /path/to/tpm2-tools:/workspace/tpm2-tools <IMAGE ID> /bin/bash -c '/workspace/tpm2-tools/.ci/docker.run'
```

or to run the [tpm2-tss](https://github.com/tpm2-software/tpm2-tss) CI sequence locally

```sh
docker run --rm --env-file /path/to/tpm2-tss/.ci/docker.env -v /path/to/tpm2-tss:/workspace/tpm2-tss <IMAGE ID> /bin/bash -c '/workspace/tpm2-tss/.ci/docker.run'
```

## Auto builds

The repository is monitored by Github Actions and repository changes are built
and submitted to Github Container Registry. The containers are listed on
[tpm2software/packages](https://github.com/orgs/tpm2-software/packages).

For example, to download and run a container based on Fedora 32 from the registry:

```sh
# With Docker
docker run -it --rm ghcr.io/tpm2-software/fedora-32 /bin/bash

# With Podman
podman run -it --rm ghcr.io/tpm2-software/fedora-32 /bin/bash
```
