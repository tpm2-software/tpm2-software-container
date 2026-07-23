FROM opensuse/leap

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

RUN zypper ref
RUN zypper -n in \
    curl \
    libcmocka-devel \
    net-tools \
    git \
    pkg-config \
    python3-pip \
    gcc \
    m4 \
    libtool \
    automake \
    libgcrypt-devel \
    openssl-devel \
    glib2-devel \
    wget \
    doxygen \
    clang \
    pandoc \
    lcov \
    libcurl-devel \
    vim \
    clang-tools \
    sqlite3-devel \
    dbus-1-devel \
    dbus-1-x11 \
    xz \
    gzip \
    which \
    gcc-c++ \
    iproute \
    libtasn1-devel \
    socat \
    libseccomp-devel \
    expect \
    gawk \
    net-tools-deprecated \
    libjson-c-devel \
    libuuid-devel \
    libyaml-devel \
    mozilla-nss-tools \
    opensc \
    java-17-openjdk-devel \
    java-17-openjdk \
    libffi-devel \
    patch \
    sqlite3 \
    openssl-engine-libp11 \
    gnutls \
    acl \
    json-glib-devel \
    libusb-devel \
    libftdi1-devel \
    openssh-common \
    gmp-devel \
    && zypper clean --all

include(`autoconf.m4')

include(`rust.m4')

include(`pip3.m4')

include(`ibmtpm1682.m4')

ENV LIBTPMS_AUTOGEN_EXTRA="--libdir=/usr/lib64"
ENV SWTPM_MAKE_EXTRA="CFLAGS=\"-I/usr/include/libseccomp/\""
include(`swtpm.m4')

include(`uthash.m4')
include(`junit.m4')
