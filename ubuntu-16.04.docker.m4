FROM ubuntu:16.04

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
    clang-6.0 \
    clang-tools-6.0 \
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
    libengine-pkcs11-openssl \
    libtasn1-6-dev \
    socat \
    libseccomp-dev \
    expect \
    gawk \
    python-pip \
    libyaml-dev \
    opensc \
    libjson-c-dev \
    default-jre \
    default-jdk \
    sqlite3 \
    libnss3-tools \
    uuid-dev \
    gnutls-bin

RUN pip  install cpp-coveralls pyasn1 pyasn1_modules python-pkcs11
RUN pip3 install cpp-coveralls pyasn1 pyasn1_modules python-pkcs11
RUN pip install --upgrade pyasn1-modules
RUN pip3 install --upgrade pyasn1-modules

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-6.0 100

include(`autoconf.m4')

# there's a bug where old versions of libpkcs11 engine were install to the wrong directory, but
# we don't want to export the variable and kill off the default engines, so symlink the wrong one
RUN ln -s /usr/lib/ssl/engines/libpkcs11.so /usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/

# Update automake to a non-broken AM_PYTHON_PATH checking version
RUN wget http://mirrors.kernel.org/ubuntu/pool/main/a/automake-1.16/automake_1.16.1-4ubuntu3_all.deb \
    && sha256sum automake_1.16.1-4ubuntu3_all.deb | grep -q '^2380a2d1c6d5a67d0be1b98ff79394bfb2a54c5c00062c57c84a95cd7ec885bf' \
    && dpkg -i automake_1.16.1-4ubuntu3_all.deb

include(`python3.7.2.m4')

RUN python3.7 -m pip install pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11

include(`ibmtpm1637.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
