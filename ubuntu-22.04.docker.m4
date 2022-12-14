FROM ubuntu:jammy

LABEL org.opencontainers.image.source https://github.com/tpm2-software/tpm2-software-container

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    autoconf-archive \
    curl \
    libcmocka0 \
    libcmocka-dev \
    net-tools \
    build-essential \
    git \
    pkg-config \
    gcc \
    g++ \
    m4 \
    libtool \
    automake \
    libgcrypt20-dev \
    libssl-dev \
    autoconf \
    gnulib \
    wget \
    doxygen \
    libdbus-1-dev \
    libglib2.0-dev \
    clang \
    clang-tools \
    pandoc \
    lcov \
    libcurl4-openssl-dev \
    dbus-x11 \
    vim-common \
    libsqlite3-dev \
    iproute2 \
    libtasn1-6-dev \
    socat \
    libseccomp-dev \
    expect \
    gawk \
    libjson-c-dev \
    libengine-pkcs11-openssl \
    default-jre \
    default-jdk \
    sqlite3 \
    libnss3-tools \
    python3 \
    python3-pip \
    libyaml-dev \
    libmbedtls-dev \
    uuid-dev \
    opensc \
    gnutls-bin \
    rustc \
    acl \
    libjson-glib-dev \
    libusb-1.0-0-dev

include(`pip3.m4')

include(`autoconf.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
