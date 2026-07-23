
RUN dnf -y install epel-release dnf-plugins-core \
    && dnf config-manager --set-enabled crb \
    && dnf -y install \
    CENTOS_LIBUSB_DEVEL \
    acl \
    autoconf-archive \
    automake \
    dbus-devel \
    dbus-libs \
    dbus-x11 \
    expect \
    file \
    gawk \
    gcc \
    git \
    glib2-devel \
    gmp-devel \
    gnulib-devel \
    gnutls-utils \
    iproute \
    json-c-devel \
    json-glib-devel \
    libasan \
    libcmocka \
    libcmocka-devel \
    libcurl-devel \
    libftdi-devel \
    libgcrypt-devel \
    liboath-devel \
    libseccomp-devel \
    libtasn1-devel \
    libtool \
    libubsan \
    libuuid-devel \
    libyaml-devel \
    m4 \
    net-tools \
    opensc \
    openssl \
    openssl-devel \
    perl-Digest-SHA \
    pkg-config \
    procps \
    python3-devel \
    python3-pyyaml \
    qrencode-devel \
    socat \
    sqlite-devel \
    uthash-devel \
    vim \
    wget \
    && dnf clean all \
    && rm -rf /var/cache/dnf
