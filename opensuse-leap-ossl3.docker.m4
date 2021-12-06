include(`opensuse-leap.docker.m4')

# Install openssl3
RUN zypper remove -y libopenssl-devel
include(`ossl3.m4')

WORKDIR /
