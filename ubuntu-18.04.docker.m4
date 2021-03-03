FROM ubuntu:18.04

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
    clang-9 \
    clang-tools-9 \
    pandoc \
    lcov \
    libcurl4-openssl-dev \
    dbus-x11 \
    python-yaml \
    python3-yaml \
    vim-common \
    python3-pip \
    libsqlite3-dev \
    python-cryptography \
    python3-cryptography \
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
    python3-pip \
    python-pip \
    libyaml-dev \
    uuid-dev \
    opensc \
    gnutls-bin

ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1
RUN pip  install cpp-coveralls pyasn1 pyasn1_modules python-pkcs11
RUN pip3 install cpp-coveralls pyasn1 pyasn1_modules python-pkcs11
RUN pip install --upgrade pyasn1-modules
RUN pip3 install --upgrade pyasn1-modules

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-9 100

include(`pip3.m4')
include(`autoconf.m4')
include(`ibmtpm1637.m4')
include(`python3.7.2.m4')

RUN python3.7 -m pip install pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11

include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
