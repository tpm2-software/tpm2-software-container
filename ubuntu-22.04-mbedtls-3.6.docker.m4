FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    acl \
    autoconf \
    autoconf-archive \
    automake \
    build-essential \
    clang \
    clang-tools \
    curl \
    dbus-x11 \
    default-jdk \
    default-jre \
    doxygen \
    expect \
    g++ \
    gawk \
    gcc \
    git \
    gnulib \
    gnutls-bin \
    iproute2 \
    lcov \
    libcmocka-dev \
    libcmocka0 \
    libcurl4-openssl-dev \
    libdbus-1-dev \
    libengine-pkcs11-openssl \
    libftdi-dev \
    libgcrypt20-dev \
    libglib2.0-dev \
    libgmp-dev \
    libjson-c-dev \
    libjson-glib-dev \
    libnss3-tools \
    libseccomp-dev \
    libsqlite3-dev \
    libssl-dev \
    libtasn1-6-dev \
    libtool \
    libusb-1.0-0-dev \
    libyaml-dev \
    m4 \
    net-tools \
    opensc \
    pandoc \
    pkg-config \
    python3 \
    python3-pip \
    rustc \
    socat \
    sqlite3 \
    uthash-dev \
    uuid-dev \
    vim-common \
    wget \
    && rm -rf /var/lib/apt/lists/*

include(`ibmtpm1682.m4')
include(`swtpm.m4')
include(`pip3.m4')
include(`junit.m4')
include(`mbedtls36.m4')

WORKDIR /
