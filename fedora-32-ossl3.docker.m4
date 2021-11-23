include(`fedora-32.docker.m4')

# Install openssl3 and curl
RUN dnf remove -y libssl-devel libcurl4-openssl-devel
RUN dnf -y install \
    perl-IPC-Cmd \
    perl-Pod-Html
include(`ossl3-curl.m4')

WORKDIR /
