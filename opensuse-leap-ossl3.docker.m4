include(`opensuse-leap.docker.m4')

# Install openssl3 and curl
RUN zypper remove -y libopenssl-devel libcurl-devel
include(`ossl3-curl.m4')

WORKDIR /
