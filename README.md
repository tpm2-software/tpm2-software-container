This repository contains metadata and scripts used to generate the container
images used for continuous integration (CI) by the various tpm2-software
projects.

## Local build

To build the container image locally invoke docker with the build command from within the tpm2-software-container directory:

```
docker build .
```

The final output of the build will be an IMAGE ID which can be used to run the container image, for example:

```
docker run -it <IMAGE ID> /bin/bash
```

or to run the tpm2-tools CI sequence locally:

```
docker run --env /path/to/tpm2-tools/.ci/docker.env -v /path/to/tpm2-tools:/workspace/tpm2-tools <IMAGE ID> /bin/bash -c '/workspace/tpm2-tools/.ci/docker.run'
```

## Auto builds

The repository is monitored by Docker Hub and the [tpm2software/tpm2-tss](https://hub.docker.com/r/tpm2software/tpm2-tss) image on the
Hub is rebuilt when the repository changes.
