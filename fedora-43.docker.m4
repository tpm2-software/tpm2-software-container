FROM fedora:43

LABEL org.opencontainers.image.source="https://github.com/tpm2-software/tpm2-software-container"

# can return 100 if packages need update
RUN dnf check-update; \
    rc=$?; \
    if [ $rc -ne 100 ] && [ $rc -ne 0 ]; then \
        echo "dnf check-update failed: $rc"; \
        exit $rc; \
    fi

RUN dnf -y install \
    acl \
    autoconf-archive \
    automake \
    clang \
    clang-analyzer \
    clang-tools-extra \
    crypto-policies-scripts \
    dbus-devel \
    dbus-libs \
    dbus-x11 \
    doxygen \
    expect \
    gawk \
    gcc \
    git \
    glib2-devel \
    gnulib \
    gnutls-utils \
    hamcrest \
    iproute \
    java-latest-openjdk \
    java-latest-openjdk-devel \
    json-c-devel \
    json-glib-devel \
    junit \
    lcov \
    libasan \
    libcmocka \
    libcmocka-devel \
    libcurl-devel \
    libftdi-devel \
    libgcrypt-devel \
    libseccomp-devel \
    libsq3-devel \
    libtasn1-devel \
    libtool \
    libubsan \
    libusb1-devel \
    libuuid-devel \
    libyaml-devel \
    m4 \
    net-tools \
    nss-tools \
    opensc \
    openssl \
    openssl-devel \
    openssl-devel-engine \
    openssl-pkcs11 \
    pandoc \
    perl-Digest-SHA \
    pkg-config \
    procps \
    python3-bcrypt \
    python3-cryptography \
    python3-devel \
    python3-pip \
    python3-pyasn1 \
    python3-pyasn1-modules \
    python3-setuptools \
    socat \
    swtpm \
    uthash-devel \
    vim \
    wget

# Tests in PKCS11 will fail becuase newer Fedora's block things like sha1 and raw RSA signatures.
# However, we WANT those tests to run, so in this container test environment, set it LEGACY mode.
RUN update-crypto-policies --set=LEGACY

RUN python3 -m pip install python-pkcs11

# make install goes into /usr/local/lib/pkgconfig which is non-standard
# Set this so ./configure can find things and we don't have to worry about prefix changes
# to build instructions
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
ENV CLASSPATH=/usr/share/java/hamcrest/hamcrest.jar:/usr/share/java/junit.jar

WORKDIR /
