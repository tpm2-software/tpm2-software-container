include(`ubuntu-20.04.docker.m4')
RUN apt-get remove -y libssl-dev libcurl4-openssl-dev
include(`ossl3-curl.m4')

WORKDIR /
