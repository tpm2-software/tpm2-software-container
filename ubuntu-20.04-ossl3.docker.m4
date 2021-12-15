include(`ubuntu-20.04.docker.m4')

# Install openssl3
RUN apt-get remove -y libssl-dev
include(`ossl3.m4')

WORKDIR /
