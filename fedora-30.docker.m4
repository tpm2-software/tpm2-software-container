FROM fedora:30

# can return 100 if packages need update
RUN yum check-update; \
    rc=$?; \
    if [ $rc -ne 100 ] && [ $rc -ne 0 ]; then \
        echo "yum check-update failed: $rc"; \
        exit $rc; \
    fi

RUN yum -y install \
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
    python3-pyyaml \
    vim \
    python3-pip \
    libsq3-devel \
    python3-cryptography \
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
    java-openjdk \
    java-openjdk-devel \
    gnutls-utils \ 
    uuid-devel \
    python3-devel

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

# we need/check for just python, Fedora comes with python3 so just symlink it
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /
