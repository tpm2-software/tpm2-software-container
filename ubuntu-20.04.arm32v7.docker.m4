FROM arm32v7/ubuntu:20.04

include(`ubuntu_20.04_base_deps.m4')
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
include(`pip3.m4')

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-10 100

include(`autoconf.m4')

ARG WGET_EXTRA_FLAGS="--no-check-certificate"
include(`ibmtpm1637.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
