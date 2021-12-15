FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add \
    autoconf-archive \
    cmocka-dev \
    net-tools \
    make \
    git \
    gcc \
    g++ \
    m4 \
    libtool \
    automake \
    autoconf \
    wget \
    doxygen \
    dbus-dev \
    glib-dev \
    clang \
    clang-analyzer \
    clang-extra-tools \
    json-c-dev  \
    iproute2 \
    coreutils \
    uthash-dev \
    curl-dev \
    python3-dev \
    py3-yaml \
    perl-utils \
    openssl \
    openssl-dev \
    acl \
    xxd \
    grep \
    dbus \
    vim \
    dbus-x11 \
    procps \
    libtasn1-dev \
    json-glib-dev \
    gnutls-dev \
    expect \
    socat \
    libseccomp-dev \
    gawk \
    gzip \
    yaml-dev \
    nss-tools \
    opensc \
    openjdk17-jdk \
    openjdk17-jre

include(`autoconf.m4')
include(`ibmtpm1637.m4')
include(`swtpm.m4')

WORKDIR /


    
