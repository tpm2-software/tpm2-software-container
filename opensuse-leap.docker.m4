FROM opensuse/leap

RUN zypper ref
RUN zypper -n in \
    curl \
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
    glib2-devel \
    wget \
    doxygen \
    clang \
    pandoc \
    lcov \
    libcurl-devel \
    vim \
    clang7-checker \
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
    java-11-openjdk-devel \
    java-11-openjdk \
    libffi-devel \
    patch \
    sqlite3 \
    openssl-engine-libp11 \
    gnutls \
    acl \
    json-glib-devel \
    python \
    python-pip

include(`autoconf.m4')
include(`python3.7.2.m4')

include(`rust.m4')

# Some other packages bring in python and python3, which at this time is too old, so we want
# python3 to be the 3.7 version just installed.
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.7 0

# Python2 since OpenSuse default
RUN python -m pip install --upgrade pip
RUN python -m pip install pyyaml

include(`pip3.m4')

# Fix Automake AM_PYTHON_PATH missing python3.7 interpreter
COPY patches/python.patch /tmp/python.patch
RUN stat /usr/share/aclocal-1.15/python.m4
RUN patch -d / -p1 < /tmp/python.patch
RUN rm /tmp/python.patch

include(`ibmtpm1637.m4')

ENV LIBTPMS_AUTOGEN_EXTRA="--libdir=/usr/lib64"
ENV SWTPM_MAKE_EXTRA="CFLAGS=\"-I/usr/include/libseccomp/\""
include(`swtpm.m4')

include(`uthash.m4')
include(`junit.m4')

WORKDIR /
