FROM ubuntu:noble

LABEL org.opencontainers.image.source https://github.com/tpm2-software/tpm2-software-container

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_REQUIRE_VIRTUALENV=0
ENV PIP_BREAK_SYSTEM_PACKAGES=1
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
    libusb-1.0-0-dev \
    libftdi-dev \
    uthash-dev \
    bear

include(`pip3-withoutupgrade.m4')

ARG ibmtpm_name=ibmtpm1682
RUN cd /tmp \
        && wget $WGET_EXTRA_FLAGS -L "https://downloads.sourceforge.net/project/ibmswtpm2/$ibmtpm_name.tar.gz" \
        && sha256sum $ibmtpm_name.tar.gz | grep ^3cb642f871a17b23d50b046e5f95f449c2287415fc1e7aeb4bdbb8920dbcb38f \
        && mkdir -p $ibmtpm_name \
        && tar xv --no-same-owner -f $ibmtpm_name.tar.gz -C $ibmtpm_name \
        && rm $ibmtpm_name.tar.gz \
        && cd $ibmtpm_name/src \
        && sed -i 's/-DTPM_NUVOTON/-DTPM_NUVOTON $(CFLAGS)/' makefile \
        && CFLAGS="-DNV_MEMORY_SIZE=32768 -DMIN_EVICT_OBJECTS=7" make -j$(nproc) \
        && cp tpm_server /usr/local/bin \
        && rm -fr /tmp/$ibmtpm_name

include(`autoconf.m4')
include(`junit.m4')

WORKDIR /
