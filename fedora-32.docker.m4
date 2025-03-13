FROM fedora:32

LABEL org.opencontainers.image.source https://github.com/tpm2-software/tpm2-software-container

# can return 100 if packages need update
RUN dnf check-update; \
    rc=$?; \
    if [ $rc -ne 100 ] && [ $rc -ne 0 ]; then \
        echo "dnf check-update failed: $rc"; \
        exit $rc; \
    fi

RUN dnf -y install \
    libcmocka \
    libcmocka-devel \
    net-tools \
    git \
    pkg-config \
    gcc \
    m4 \
    libtool \
    automake \
    libgcrypt-devel \
    openssl-devel \
    gnulib \
    glib2-devel \
    wget \
    doxygen \
    dbus-libs \
    dbus-devel \
    clang \
    clang-analyzer \
    clang-tools-extra \
    pandoc \
    lcov \
    libcurl-devel \
    dbus-x11 \
    vim \
    python3-pip \
    libsq3-devel \
    iproute \
    procps \
    libasan \
    libubsan \
    perl-Digest-SHA \
    libtasn1-devel \
    socat \
    libseccomp-devel \
    expect \
    gawk \
    json-c-devel \
    libyaml-devel \
    nss-tools \
    expect \
    opensc \
    java-latest-openjdk-1:13.0.2.8-1.rolling.fc32 \
    java-latest-openjdk-devel-1:13.0.2.8-1.rolling.fc32 \
    gnutls-utils \
    libuuid-devel \
    python3-devel \
    openssl-pkcs11 \
    acl \
    json-glib-devel \
    libusb-devel \
    libftdi-devel \
    gmp-devel

include(`pip3.m4')
include(`autoconf.m4')
include(`ibmtpm1637.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

# make install goes into /usr/local/lib/pkgconfig which is non-standard
# Set this so ./configure can find things and we don't have to worry about prefix changes
# to build instructions
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

WORKDIR /
