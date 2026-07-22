FROM --platform=linux/arm/v7 ubuntu:26.04

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

include(`ubuntu_26.04_base_deps.m4')

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-21 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-21 100

include(`autoconf.m4')
include(`ibmtpm1682.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
