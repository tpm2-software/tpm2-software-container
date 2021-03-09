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
    vim-common \
    libsqlite3-dev \
    libengine-pkcs11-openssl \
    libtasn1-6-dev \
    socat \
    libseccomp-dev \
    expect \
    gawk \
    libyaml-dev \
    opensc \
    libjson-c-dev \
    default-jre \
    default-jdk \
    sqlite3 \
    libnss3-tools \
    uuid-dev \
    gnutls-bin \
    rustc \
    acl

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-6.0 100

include(`autoconf.m4')

# We want python3.7 since tpm2-pkcs11 needs it, and other projects need a valid python
include(`python3.7.2.m4')
RUN update-alternatives --install /usr/local/bin/python3 python3 /usr/local/bin/python3.7 100
RUN python3.7 -m pip install 'cryptography==3.2.1'
RUN python3.7 -m pip install pyyaml cpp-coveralls pyasn1 pyasn1_modules python-pkcs11

# there's a bug where old versions of libpkcs11 engine were install to the wrong directory, but
# we don't want to export the variable and kill off the default engines, so symlink the wrong one
RUN ln -s /usr/lib/ssl/engines/libpkcs11.so /usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/

# Update automake to a non-broken AM_PYTHON_PATH checking version
RUN wget http://http.us.debian.org/debian/pool/main/a/automake-1.16/automake_1.16.3-2_all.deb -O automake.deb \
    && sha256sum automake.deb | grep -q '^720feb778ab6c33a28edf5815b747a7082b01ba358551cd35e99db8dfe73a136' \
    && dpkg -i automake.deb


include(`ibmtpm1637.m4')
include(`swtpm.m4')
include(`uthash.m4')
include(`junit.m4')

WORKDIR /
