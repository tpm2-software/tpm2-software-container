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
    clang-22 \
    clang-format-22 \
    clang-tidy-22 \
    clang-tools-22 \
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
    junit4 \
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
    libgmp-dev \
    libftdi-dev \
    swtpm \
    uthash-dev \
    bear

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-22 100
RUN update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-22 100
